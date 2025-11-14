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
    @Binding var bookedLessons: [Lesson]
    
    private func isBooked(_ lesson: Lesson) -> Bool {
        bookedLessons.contains(where: { $0.id == lesson.id })
    }
    
    var body: some View {
        ZStack {
            Image(backgroundImageName(for: course.name))
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.0)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                HStack(alignment: .center, spacing: 12) {
                    Image(systemName: symbol(for: course.name))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .foregroundColor(color(for: course.name))
                    Text(course.name)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.black)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Lessons")
                        .font(.headline)
                        .foregroundStyle(.black)
                    
                    ForEach(Array(course.schedules.enumerated()), id: \.element.id) { index, lesson in
                        let booked = isBooked(lesson)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundColor(.primary)
                                Text(lesson.time)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            
                            HStack(spacing: 24) {
                                VStack {
                                    Text("Available Seats")
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                    Text("\(lesson.availableSeats)")
                                        .font(.title)
                                        .bold()
                                        .foregroundStyle(.black)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.green.opacity(0.75)))
                                
                                VStack {
                                    Text("Registered")
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                    Text("\(lesson.enrolledCount)")
                                        .font(.title)
                                        .bold()
                                        .foregroundStyle(.black)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.yellow.opacity(0.75)))
                            }
                            .padding(.top, 8)
                            
                            Button(booked ? "-  Delete Reservation " : "+  Book ") {
                                if booked {
                                    if let removeIndex = bookedLessons.firstIndex(where: { $0.id == lesson.id }) {
                                        bookedLessons.remove(at: removeIndex)
                                    }
                                    if course.schedules[index].enrolledCount > 0 {
                                        course.schedules[index].enrolledCount -= 1
                                    }
                                } else {
                                    if course.schedules[index].availableSeats > 0 {
                                        course.schedules[index].enrolledCount += 1
                                        if !bookedLessons.contains(where: { $0.id == lesson.id }) {
                                            bookedLessons.append(course.schedules[index])
                                        }
                                    }
                                }
                            }
                            .disabled(course.schedules[index].availableSeats == 0 && !booked)
                            .buttonStyle(.borderedProminent)
                            .tint(.yellow.opacity(0.75))
                            .foregroundColor(.black)
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(Color(.secondarySystemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(Color(.separator), lineWidth: 0.5)
                        )
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                    }
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("")
    }
}
