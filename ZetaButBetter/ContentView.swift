import SwiftUI

struct ProfileButton: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(.white))
                .frame(width: 34, height: 34)

            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.green)
                .frame(width: 28, height: 28)
        }
        .accessibilityLabel("Profile")
    }
}
struct Course: Identifiable {
    let id = UUID()
    let name: String
    var schedules: [Lesson]
}

struct Lesson: Identifiable, Equatable {
    let id = UUID()
    let time: String
    var enrolledCount: Int
    let courseName: String
    var availableSeats: Int { 20 - enrolledCount }
}

struct ContentView: View {
    @State private var bookedLessons: [Lesson] = []
    @FocusState private var isMyClubDatePickerFocused: Bool

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
        default: return "thumb_default"
        }
    }
    
    @State private var selectedTab = 2
    @State private var selectedDate = Date()
    @State private var searchText = ""
    @State private var courses = [
        Course(name: "Yoga", schedules: [Lesson(time: "8:00", enrolledCount: 0, courseName: "Yoga"), Lesson(time: "18:00", enrolledCount: 0, courseName: "Yoga")]),
        Course(name: "Pilates", schedules: [Lesson(time: "9:00", enrolledCount: 0, courseName: "Pilates"), Lesson(time: "19:00", enrolledCount: 0, courseName: "Pilates")]),
        Course(name: "Spinning", schedules: [Lesson(time: "9:00", enrolledCount: 0, courseName: "Spinning"), Lesson(time: "19:00", enrolledCount: 0, courseName: "Spinning")]),
        Course(name: "CrossFit", schedules: [Lesson(time: "9:00", enrolledCount: 0, courseName: "CrossFit"), Lesson(time: "19:00", enrolledCount: 0, courseName: "CrossFit")]),
        Course(name: "Zumba", schedules: [Lesson(time: "9:00", enrolledCount: 0, courseName: "Zumba"), Lesson(time: "19:00", enrolledCount: 0, courseName: "Zumba")]),
        Course(name: "Functional", schedules: [Lesson(time: "9:00", enrolledCount: 0, courseName: "Functional"), Lesson(time: "19:00", enrolledCount: 0, courseName: "Functional")]),
        Course(name: "Kombat", schedules: [Lesson(time: "9:00", enrolledCount: 0, courseName: "Kombat"), Lesson(time: "19:00", enrolledCount: 0, courseName: "Kombat")]),
        Course(name: "Step", schedules: [Lesson(time: "9:00", enrolledCount: 0, courseName: "Step"), Lesson(time: "19:00", enrolledCount: 0, courseName: "Step")]),
        Course(name: "Pump", schedules: [Lesson(time: "9:00", enrolledCount: 0, courseName: "Pump"), Lesson(time: "19:00", enrolledCount: 0, courseName: "Pump")]),
        Course(name: "Tonic", schedules: [Lesson(time: "9:00", enrolledCount: 0, courseName: "Tonic"), Lesson(time: "19:00", enrolledCount: 0, courseName: "Tonic")]),
        Course(name: "Cross Training", schedules: [Lesson(time: "9:00", enrolledCount: 0, courseName: "Cross Training"), Lesson(time: "19:00", enrolledCount: 0, courseName: "Cross Training")]),
        Course(name: "Flex", schedules: [Lesson(time: "9:00", enrolledCount: 0, courseName: "Flex"), Lesson(time: "19:00", enrolledCount: 0, courseName: "Flex")])
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
                
                NavigationStack{
                    Text("Tab Content 1")
                        .navigationTitle("Home")
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink {
                                        ProfileView()
                                    } label: {
                                        ProfileButton()
                                    }
                                }
                            }
                } .navigationTitle("Home")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink {
                                ProfileView()
                            } label: {
                                ProfileButton()
                            }
                        }
                    }
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
                        .tint(.green)
                        .padding(.horizontal)
                       

                        List {
                            ForEach(filteredCourses) { course in
                                if let courseIndex = courses.firstIndex(where: { $0.id == course.id }) {
                                    NavigationLink(
                                        destination: CourseDetailView(
                                            course: $courses[courseIndex],
                                            bookedLessons: $bookedLessons
                                        )
                                    ) {
                                        ZStack(alignment: .leading) {
                                            Image(thumbnailImageName(for: course.name))
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: 120)
                                                .clipped()
                                            
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.black.opacity(1), Color.black.opacity(0.05)]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                            .frame(height: 120)
                                            
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
                                                
                                                VStack(alignment: .leading, spacing: 4) {
                                                    Text(course.name)
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                    HStack(spacing: 6) {
                                                        Image(systemName: symbol(for: course.name))
                                                            .foregroundColor(color(for: course.name))
                                                        if let first = course.schedules.first {
                                                            Text("\(first.availableSeats) seats available")
                                                                .font(.caption)
                                                                .foregroundColor(.white.opacity(0.85))
                                                        }
                                                    }
                                                    if course.schedules.count >= 2 {
                                                        HStack(spacing: 6) {
                                                            Image(systemName: "clock")
                                                                .foregroundColor(.white.opacity(0.9))
                                                            Text(course.schedules[0].time + "   |   " + course.schedules[1].time)
                                                                .font(.caption2)
                                                                .foregroundColor(.white.opacity(0.85))
                                                                .lineLimit(1)
                                                                .truncationMode(.tail)
                                                        }
                                                    } else if let only = course.schedules.first {
                                                        HStack(spacing: 6) {
                                                            Image(systemName: "clock")
                                                                .foregroundColor(.white.opacity(0.9))
                                                            Text(only.time)
                                                                .font(.caption2)
                                                                .foregroundColor(.white.opacity(0.85))
                                                                .lineLimit(1)
                                                                .truncationMode(.tail)
                                                        }
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
                        .searchable(text: $searchText, prompt: "Search class")
                    }
                    .navigationTitle("Book a class")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink {
                                ProfileView()
                            } label: {
                                ProfileButton()
                            }
                        }
                    }
                    
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
                            .foregroundColor(.green)
                            .padding(.top, 8)
                        DatePicker(
                            "",
                            selection: .constant(Date()),
                            displayedComponents: [.date]
                                
                        )
                        .datePickerStyle(.graphical)
                        .tint(.green)
                        .padding(.horizontal)
                       
                        
                        NavigationLink(
                            destination: BookedCoursesView(
                                bookedLessons: bookedLessons
                            )
                        ) {
                            HStack {
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(.green)
                                Text("Booked Classes")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.green)
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
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink {
                                ProfileView()
                            } label: {
                                ProfileButton()
                            }
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                .tag(3)
                
              
            }
        
    }
       
}

#Preview {
    ContentView()
}
