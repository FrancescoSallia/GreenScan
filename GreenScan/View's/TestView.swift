//
//  TestView.swift
//  GreenScan
//
//  Created by Francesco Sallia on 16.03.25.
//

import SwiftUI

struct TestView: View {
    
    @State var dummyData: [Dummy] = [
        Dummy(name: "Max", lastname: "Mustermann"),
        Dummy(name: "Erika", lastname: "Musterfrau"),
        Dummy(name: "John", lastname: "Doe"),
        Dummy(name: "Jane", lastname: "Doe"),
        Dummy(name: "Alex", lastname: "Smith"),
        Dummy(name: "Maria", lastname: "Gonzalez")
    ]
    
    
    var body: some View {
        
        VStack {
            Gauge(value: 20.0, in: 0...100) {
                Text("20%")
            }
            .gaugeStyle(.accessoryCircular)
            
            
            Gauge(value: 30.0, in: 0...100) {
                Text("30%")
            } currentValueLabel: {
                Image(systemName: "face.smiling")
            } minimumValueLabel: {
                Text("A")
            } maximumValueLabel: {
                Text("A")
            }
            .gaugeStyle(.accessoryCircular)
            
            Gauge(value: 20.0, in: 0...100) {
                Text("hello")
            } currentValueLabel: {
                Text("Current")
            }
            .gaugeStyle(.accessoryCircular)
            
            
            Gauge(value: 68.0, in: 0...100) {
                Text("68%")
            } currentValueLabel: {
                        Image(systemName: "face.smiling")
                            .frame(width: 80, height: 70)
                    }
                    .gaugeStyle(.accessoryCircular)
                    .tint(LinearGradient(colors: [.red, .yellow, .green], startPoint: .topLeading, endPoint: .topTrailing))
                    .frame(width: 100, height: 100)


            
        }

    }
}

#Preview {
    TestView()
}
