import SwiftUI

struct BookedCoursesView: View {
    let bookedCourses: [Course]
    var body: some View {
        VStack {
           
            List(bookedCourses) { course in
                HStack(spacing: 16) {
                    Image(systemName: symbol(for: course.name))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(color(for: course.name))
                        .padding(.vertical, 8)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(course.name)
                            .font(.headline)
                        HStack(spacing: 12) {
                            Label("\(course.enrolledCount)", systemImage: "person.2.fill")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Label("\(course.availableSeats)", systemImage: "chair.fill")
                                .font(.caption)
                                .foregroundColor(.secondary)
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
        .navigationTitle("Booked Courses")
    }
}
