import SwiftUI


struct BookedCoursesView: View {
    let bookedLessons: [Lesson]

    var body: some View {
        VStack {
            List(bookedLessons) { lesson in
                HStack(spacing: 16) {
                    Image(systemName: symbol(for: lesson.courseName))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(color(for: lesson.courseName)) 
                        .padding(.vertical, 8)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Lesson at \(lesson.time)")
                            .font(.headline)
                        HStack(spacing: 12) {
                            Label("\(lesson.enrolledCount)", systemImage: "person.2.fill")
                                .font(.caption)
                                .foregroundColor(.yellow)
                            Label("\(lesson.availableSeats)", systemImage: "chair.fill")
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                    }
                    Spacer()
                }
                .padding(.vertical, 6)
            }
            .listStyle(.plain)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Booked Classes")
    }
}
