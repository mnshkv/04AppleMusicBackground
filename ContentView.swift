import SwiftUI

struct CustomButton: ButtonStyle {
    @State var start = false
    @State var isPressed = false
    @Binding var isActive: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.all)
            .background(isPressed || start ? Color.secondary : .clear)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .scaleEffect(isPressed || start ? 0.86 : 1)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                withAnimation(.smooth(duration: 0.22, extraBounce: 0.5)) {
                    isPressed = newValue
                }
                if (oldValue && !start) {
                    withAnimation(.smooth(duration: 0.22, extraBounce: 0.5)) {
                        start = true
                        isActive = oldValue
                    } completion: {
                        isActive = false                        
                        withAnimation {
                            start = false
                        }
                    }
                }
            }
    }
}

struct ContentView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {}, label: {
                HStack(spacing: .zero) {
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: isActive ? 20 : 0, height: isActive ? 20 : 0)
                        .opacity(isActive ? 1 : 0)
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: isActive ? 1 : 20, height: isActive ? 1 : 20)
                        .opacity(isActive ? 0 : 1)
                }
            })
            .buttonStyle(CustomButton(isActive: $isActive))
        }
    }
}
