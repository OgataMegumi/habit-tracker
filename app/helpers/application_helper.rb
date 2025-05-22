module ApplicationHelper
  def task_category_image_map
    {
      "Running" => "running.png",
      "Walking" => "walking.png",
      "Strength Training" => "training.png",
      "Stretching" => "stretch.png",
      "Yoga" => "yoga.png",
      "Other Sports" => "other_ports.png",
      "Saving" => "saving.png",
      "Investing" => "investment.png",
      "Programming" => "programming.png",
      "Languages" => "language_study.png",
      "English Conversation" => "english_conversation.png",
      "Task Management" => "task_management.png",
      "Skill Development" => "skill_up.png",
      "Side Job" => "side_job.png",
      "Mental Care" => "mental_care.png",
      "Sleep" => "sleep.png",
      "Balanced Diet" => "balanced_diet.png",
      "Home Cooking" => "cooking.png",
      "Low-Carb Diet" => "low_carb.png",
      "Dieting" => "diet.png",
      "Music" => "music.png",
      "Writing" => "writing.png",
      "Photography" => "photography.png",
      "Outdoor Activities" => "outdoor.png",
      "Volunteering" => "volunteer.png",
      "Event Participation" => "event.png",
      "Networking" => "socializing.png",
      "Reading" => "reading.png",
      "Journaling" => "diary.png",
      "Tidying Up" => "cleaning.png",
      "Decluttering" => "decluttering.png",
      "Digital Detox" => "digital_detox.png",
      "Other" => "other.png"
    }    
  end

  def hide_header_for_devise_page?
    hidden_devise_pages = [
      { controller: "sessions", action: "new" },
      { controller: "registrations", action: "new" },
      { controller: "passwords", action: "new" },
      { controller: "users", action: "index" }
    ]

    hidden_devise_pages.any? do |page|
      controller_name == page[:controller] && action_name == page[:action]
    end
  end
end
