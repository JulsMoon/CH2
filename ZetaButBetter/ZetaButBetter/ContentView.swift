import SwiftUI

struct Course: Identifiable, Equatable {
    let id = UUID()
    let name: String
    var enrolledCount: Int
    var availableSeats: Int { 20 - enrolledCount }
}

struct ContentView: View {
    @State private var bookedCourses: [Course] = []

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
        default: return "course_default" // se la vuoi, crea l'asset "course_default"
        }
    }
    func thumbnailImageName(for course: String) -> String {
        switch course {
        case "Yoga": return "thumb_yoga"
        case "Pilates": return "thumb_pilates"
        case "Spinning": return "thumb_spinning"
        case "CrossFit": return "thumb_crossfit"
        case "Zumba": return "thumb_zumba"
        case "Functional": return "thumb_functional"
        case "Kombat": return "thumb_kombat"
        case "Step": return "thumb_step"
        case "Pump": return "thumb_pump"
        case "Tonic": return "thumb_tonic"
        case "Cross Training": return "thumb_cross_training"
        case "Flex": return "thumb_flex"
        default: return "thumb_default" // opzionale: aggiungi un asset di fallback
        }
    }
    
    @State private var selectedTab = 2
    @State private var selectedDate = Date()
    @State private var searchText = ""
    @State private var courses = [
        Course(name: "Yoga", enrolledCount: 0),
        Course(name: "Pilates", enrolledCount: 0),
        Course(name: "Spinning", enrolledCount: 0),
        Course(name: "CrossFit", enrolledCount: 0),
        Course(name: "Zumba", enrolledCount: 0),
        Course(name: "Functional", enrolledCount: 0),
        Course(name: "Kombat", enrolledCount: 0),
        Course(name: "Step", enrolledCount: 0),
        Course(name: "Pump", enrolledCount: 0),
        Course(name: "Tonic", enrolledCount: 0),
        Course(name: "Cross Training", enrolledCount: 0),
        Course(name: "Flex", enrolledCount: 0)
    ]

    var filteredCourses: [Course] {
        if searchText.isEmpty {
            return courses
        } else {
            return courses.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab Content 1")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(1)

            NavigationStack {
                VStack{
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .padding(.horizontal)

                    List {
                        ForEach(filteredCourses) { course in
                            let index = courses.firstIndex(where: { $0.id == course.id })
                            if let index {
                                NavigationLink(
                                    destination: CourseDetailView(
                                        course: $courses[index],
                                        bookedCourses: $bookedCourses
                                    )
                                ) {
                                    ZStack(alignment: .leading) {
                                        // Immagine di sfondo
                                        Image(thumbnailImageName(for: course.name))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 120)
                                            .clipped()

                                        // Overlay per leggibilità
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.black.opacity(1), Color.black.opacity(0.05)]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                        .frame(height: 120)

                                        // Contenuto della riga
                                        HStack(spacing: 12) {
                                            Image(thumbnailImageName(for: course.name))
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 56, height: 56)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color(.separator), lineWidth: 0.5)
                                                )

                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(course.name)
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                HStack(spacing: 6) {
                                                    Image(systemName: symbol(for: course.name))
                                                        .foregroundColor(color(for: course.name))
                                                    Text("\(course.availableSeats) seats available")
                                                        .font(.caption)
                                                        .foregroundColor(.white.opacity(0.85))
                                                }
                                            }

                                            Spacer()
                                        }
                                        .padding(.vertical, 6)
                                        .padding(.horizontal)
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                    .listRowSeparator(.hidden)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .frame(maxHeight: .infinity)
                    .searchable(text: $searchText, prompt: "Search course")
                }
                .navigationTitle("Book a course")
              
            }
            .tabItem {
                Image(systemName: "figure.strengthtraining.traditional")
                Text("My Club")
            }
            .tag(2)

            NavigationStack {
                VStack(spacing: 16) {
                    Text("Select date")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.accentColor)
                        .padding(.top, 8)
                    DatePicker(
                        "",
                        selection: .constant(Date()),
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    .padding(.horizontal)

                    NavigationLink(
                        destination: BookedCoursesView(
                            bookedCourses: bookedCourses
                        )
                    ) {
                        HStack {
                            Image(systemName: "bookmark.fill")
                                .foregroundColor(.accentColor)
                            Text("Booked Courses")
                                .font(.headline)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemGray6))
                        )
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .navigationTitle("Club Calendar")
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Calendar")
            }
            .tag(3)

            // Account tab
            Text("Tab Content 4")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Account")
                }
                .tag(4)
        }
    }
}

#Preview {
    ContentView()
}
