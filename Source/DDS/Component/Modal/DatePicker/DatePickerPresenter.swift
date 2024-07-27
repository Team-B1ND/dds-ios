import SwiftUI

public struct DodamDatePickerPresenter<C: View>: ModalViewProtocol {
    @StateObject private var provider: DatePickerProvider
    @State private var size: CGSize = .zero
    @State private var monthDate: Date = .now
    private let calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko-KR")
        return calendar
    }()
    private let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
    let content: () -> C
    
    init(
        provider: DatePickerProvider,
        @ViewBuilder content: @escaping () -> C
    ) {
        self._provider = .init(wrappedValue: provider)
        self.content = content
    }
    
    func dismiss() {
        provider.isPresent = false
    }
    
    private var range: Int? {
        calendar.range(of: .day, in: .month, for: monthDate)?.count
    }
    
    private var weeks: [[Date?]] {
        // 해당 월의 첫째 날
        var components = calendar.dateComponents([.year, .month], from: monthDate)
        components.day = 1
        let firstDayOfMonth = calendar.date(from: components)!
        
        // 첫째 날의 요일 (일요일 = 1, 월요일 = 2, ..., 토요일 = 7)
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        // 날짜 배열 생성
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        days += Array(1...(range ?? 0)).compactMap {
            components.day = $0
            return calendar.date(from: components)
        }
        days += Array(repeating: nil, count: (7 - days.count % 7) % 7)
        
        // 주 단위로 배열을 나눔
        return stride(from: 0, to: days.count, by: 7).map {
            Array(days[$0..<$0 + 7])
        }
    }
    
    private func isEnabled(_ date: Date, between startDate: Date, and endDate: Date) -> Bool {
        let startComponents = calendar.dateComponents([.year, .month, .day], from: startDate)
        let endComponents = calendar.dateComponents([.year, .month, .day], from: endDate)
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        if let start = calendar.date(from: startComponents),
           let end = calendar.date(from: endComponents),
           let target = calendar.date(from: dateComponents) {
            return (start...end).contains(target)
        }
        
        return false
    }
    
    public var body: some View {
            BaseModal(
                isPresent: $provider.isPresent,
                content: content
            ) {
                if let datePicker = provider.datePicker {
                    VStack(spacing: 16) {
                        makeHeader(datePicker: datePicker)
                        makeCalendarView(datePicker: datePicker)
                        HStack {
                            Spacer()
                            DodamTextButton.large(title: "선택", color: DodamColor.Primary.normal) {
                                datePicker.action()
                                dismiss()
                            }
                        }
                    }
                    .padding(24)
                    .frame(width: 328)
                    .clipShape(.extraLarge)
                }
            }
            .animation(.spring, value: monthDate)
    }
    
    @ViewBuilder
    private func makeHeader(datePicker: DatePicker) -> some View {
        VStack(spacing: 4) {
            Text(datePicker.title)
                .heading2(.bold)
                .foreground(DodamColor.Label.strong)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 8) {
                Text(
                    String(calendar.dateComponents([.year], from: monthDate).year ?? 0)
                    + "년 "
                    + String(calendar.dateComponents([.month], from: monthDate).month ?? 0)
                    + "월")
                    .body1(.medium)
                    .foreground(DodamColor.Label.strong)
                Spacer()
                Button {
                    if let date = calendar.date(byAdding: .month, value: -1, to: monthDate) {
                        self.monthDate = date
                    }
                } label: {
                    Image(icon: .chevronLeft)
                        .resizable()
                        .foreground(DodamColor.Primary.normal)
                        .frame(width: 20, height: 20)
                        .padding(8)
                }
                Button {
                    if let date = calendar.date(byAdding: .month, value: 1, to: monthDate) {
                        self.monthDate = date
                    }
                } label: {
                    Image(icon: .chevronRight)
                        .resizable()
                        .foreground(DodamColor.Primary.normal)
                        .frame(width: 20, height: 20)
                        .padding(8)
                }
            }
        }
        .animation(.none, value: monthDate)
    }
    
    @ViewBuilder
    private func makeCalendarView(datePicker: DatePicker) -> some View {
        VStack(spacing: 0) {
            // header
            HStack(spacing: 0) {
                ForEach(weekdays, id: \.self) { week in
                    Text(week)
                        .label(.regular)
                        .foreground(DodamColor.Label.alternative)
                        .frame(maxWidth: .infinity)
                }
            }
            // days
            ForEach(weeks, id: \.self) { week in
                HStack(spacing: 0) {
                    ForEach(week, id: \.self) { day in
                        let enabled = isEnabled(
                            day ?? .now,
                            between: datePicker.startDate,
                            and: datePicker.endDate
                        )
                        let selected = day == provider.date
                        Button {
                            provider.date = day ?? .now
                        } label: {
                            Text(day == nil ? "" : "\(calendar.component(.day, from: day!))")
                                .headline(.medium)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 4)
                                .opacity({
                                    guard day != nil else {
                                        return 0
                                    }
                                    return enabled ? 1 : 0.5
                                }())
                                .foreground(
                                    selected
                                    ? DodamColor.Static.white
                                    : DodamColor.Label.alternative
                                )
                                .background {
                                    if selected {
                                        Rectangle()
                                            .dodamFill(DodamColor.Primary.normal)
                                            .frame(width: 38, height: 38)
                                            .clipShape(.small)
                                    }
                                }
                        }
                        .disabled(!enabled)
                    }
                }
            }
        }
        .animation(.none, value: monthDate)
    }
}

private struct DatePickerPreview: View {
    @StateObject private var provider = DatePickerProvider()
    @State var hour = 0
    @State var minute = 0
    var body: some View {
        DodamDatePickerPresenter(provider: provider) {
            VStack {
                Button("Show") {
                    provider.present(.init(
                        title: "외출 일시",
                        startDate: .now,
                        endDate: {
                            var d = Date.now
                            d = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: d)!
                            return d
                        }()) {
                            print("Hello")
                        }
                    )
                }
            }
        }
        .registerPretendard()
    }
}

#Preview {
    DatePickerPreview()
}

#Preview {
    DatePickerPreview()
        .preferredColorScheme(.dark)
}
