module TaskContents
    FREQUENCY_UNITS_LIST = [ "日" ]

    CATEGORIES_GROUPS = {
        "Exercise" => [ "Running", "Walking", "Strength Training", "Stretching", "Yoga", "Other Sports" ],
        "Finance" => [ "Saving", "Investing" ],
        "Learning" => [ "Programming", "Languages", "English Conversation" ],
        "Career" => [ "Task Management", "Skill Development", "Side Job" ],
        "Health" => [ "Mental Care", "Sleep", "Balanced Diet", "Home Cooking", "Low-Carb Diet", "Dieting" ],
        "Hobbies" => [ "Music", "Writing", "Photography", "Outdoor Activities" ],
        "Social Activities" => [ "Volunteering", "Event Participation", "Networking" ],
        "Life Logging" => [ "Reading", "Journaling" ],
        "Daily Life" => [ "Tidying Up", "Decluttering", "Digital Detox" ],
        "Others" => [ "Other" ]
    }

    COLORS = %w[orange blue green yellow yellowgreen red]

    COLOR_CODES = {
    "orange" => "#ff9318",
    "blue" => "#5fa9cb",
    "green" => "#1f785b",
    "yellow" => "#fab700",
    "yellowgreen" => "#b1df43",
    "red" => "#ff272e"
    }
end
