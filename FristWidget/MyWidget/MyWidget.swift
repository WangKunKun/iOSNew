//
//  MyWidget.swift
//  MyWidget
//
//  Created by wangk on 2023/12/19.
//

import WidgetKit
import SwiftUI

//提供数据
struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), time: CommonTool.getTime())
    }

    //获取小组件快照
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        let entry = SimpleEntry(date: Date(), time: CommonTool.getTime())
        completion(entry)
    }
    //获取当前时间和未来时间的数据
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let time = CommonTool.getTime()
        //循环 小组件的刷新频率，但是并不完全精准，因为系统会根据你的情况来判断 加入多少个Entry就是多少的频次
        //这里只添加了一天 添加多天会如何
        switch time {
        case .morning:
            entries.append(SimpleEntry(date: Date(), time: .morning))
            entries.append(SimpleEntry(date: CommonTool.getDate(in: 12), time: .afternoon))
            entries.append(SimpleEntry(date: CommonTool.getDate(in: 18), time: .night))
        case .afternoon:
            entries.append(SimpleEntry(date: Date(), time: .afternoon))
            entries.append(SimpleEntry(date: CommonTool.getDate(in: 18), time: .night))
        default:
            entries.append(SimpleEntry(date: Date(), time: .night))
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

//数据模型
struct SimpleEntry: TimelineEntry {
    
    enum Time {
        case morning, afternoon, night
    }
    
    let date: Date
    let time: Time
}

extension SimpleEntry.Time {
    var text: String {
            switch self {
            case .morning:
                return "上午"
            case .afternoon:
                return "下午"
            case .night:
                return "晚上"
            }
        }
        
        var icon: String {
            switch self {
            case .morning:
                return "sunrise"
            case .afternoon:
                return "sun.max.fill"
            case .night:
                return "sunset"
            }
        }
}
//入口视图
struct MyWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 10) {
                    Image(systemName: entry.time.icon)
                        .imageScale(.large)
                        .fontWeight(.medium)
                        .foregroundColor(.red)
                    HStack {
                        Text("现在是:")
                        Text(entry.time.text)
                    }
                    .font(.subheadline)
                }
    }
}

struct MyWidget: Widget {
    //唯一标识
    let kind: String = "MyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MyWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MyWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("王琨琨")
        .description("我的第一个小组件")
    }
}


struct CommonTool {
    static func getDate(in hour: Int) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = 0
        components.second = 0

        return calendar.date(from: components)!
    }

    static func getTime(with date:Date = Date()) -> SimpleEntry.Time {
        let hour = Calendar.current.component(.hour, from:date)
        switch hour {
        case 8..<12:
            return .morning
        case 12..<18:
            return .afternoon
        default:
            return .night
        }
    }
}


