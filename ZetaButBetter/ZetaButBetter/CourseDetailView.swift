import SwiftUI
func symbol(for course: String) -> String {
    switch course {
    case "Yoga": return "figure.mind.and.body"
    case "Pilates": return "figure.cooldown"
    case "Spinning": return "bicycle"
    case "CrossFit": return "flame"
    case "Zumba": return "music.note"
    case "Functional": return "figure.core.training"
    case "Kombat": return "figure.boxing"
    case "Step": return "figure.step.training"
    case "Pump": return "dumbbell"
    case "Tonic": return "figure.strengthtraining.functional"
    case "Cross Training": return "figure.strengthtraining.traditional"
    case "Flex": return "figure.flexibility"
    default: return "figure.walk"
    }
}

func color(for course: String) -> Color {
    switch course {
    case "Yoga": return .mint
    case "Pilates": return .indigo
    case "Spinning": return .orange
    case "CrossFit": return .red
    case "Zumba": return .pink
    case "Functional": return .blue
    case "Kombat": return .purple
    case "Step": return .teal
    case "Pump": return .yellow
    case "Tonic": return .green
    case "Cross Training": return .brown
    case "Flex": return .cyan
    default: return .gray
    }
}
func backgroundImageName(for course: String) -> String {
    switch course {
    case "Yoga": return "course_yoga"
    case "Pilates": return "course_pilates"
    case "Spinning": return "course_spinning"
    case "CrossFit": return "course_crossfit"
    case "Zumba": return "course_zumba"
    case "Functional": return "course_functional"
    case "Kombat": return "course_kombat"
    case "Step": return "course_step"
    case "Pump": return "course_pump"
    case "Tonic": return "course_tonic"
    case "Cross Training": return "course_cross_training"
    case "Flex": return "course_flex"
    default: return "course_default"
    }
}
struct CourseDetailView: View {
    @Binding var course: Course
    @Binding var bookedCourses: [Course]
    
    private var isBooked: Bool {
        bookedCourses.contains(where: { $0.id == course.id })
    }

    var body: some View {
        ZStack {
           
            Image(backgroundImageName(for: course.name))
                .resizable()
                .scaledToFill()
                

          
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.0)]),
                startPoint: .top,
                endPoint: .bottom
            )
            

         
            VStack(spacing: 24) {
                // --- Titolo con simbolo ---
                HStack(alignment: .center, spacing: 12) {
                    Image(systemName: symbol(for: course.name))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .foregroundColor(color(for: course.name))
                    Text(course.name)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.black) // per leggibilità sullo sfondo
                }
                
                HStack(spacing: 24) {
                    VStack {
                        Text("Available Places")
                            .font(.headline)
                            .foregroundStyle(.black)
                        Text("\(course.availableSeats)")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.green.opacity(0.25)))

                    VStack {
                        Text("Registered")
                            .font(.headline)
                            .foregroundStyle(.black)
                        Text("\(course.enrolledCount)")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.25)))
                }
                .padding(.top, 40)

                Button(isBooked ? "Delete Reservation" : "Book") {
                    if isBooked {
                        if let index = bookedCourses.firstIndex(where: { $0.id == course.id }) {
                            bookedCourses.remove(at: index)
                            if course.enrolledCount > 0 {
                                course.enrolledCount -= 1
                            }
                        }
                    } else {
                        if course.availableSeats > 0 {
                            course.enrolledCount += 1
                            if !bookedCourses.contains(where: { $0.id == course.id }) {
                                bookedCourses.append(course)
                            }
                        }
                    }
                }
                .disabled(course.availableSeats == 0 && !isBooked)
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("")
    }
}
