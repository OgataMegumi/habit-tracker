demo_user = User.find_or_create_by!(email: 'demo@example.com') do |user|
  user.password = 'P@ssw0rd'
  user.password_confirmation = 'P@ssw0rd'
end

puts "✅ Demo user created: #{demo_user.email}"

demo_user.tasks.destroy_all
puts "🧹 Old tasks removed for demo user"

task_templates = [
  {
    title: "朝のストレッチ",
    description: "毎朝の軽いストレッチで身体を目覚めさせる",
    category: "Stretching",
    frequency_number: 1, frequency_unit: "日", frequency_in_days: 1.0
  },
  {
    title: "英単語を10分読む",
    description: "語彙力を増やすために単語帳を毎日読む",
    category: "Languages",
    frequency_number: 1, frequency_unit: "日", frequency_in_days: 1.0
  },
  {
    title: "週1ランニング",
    description: "体力向上と気分転換を目的としたランニング",
    category: "Running",
    frequency_number: 1, frequency_unit: "日", frequency_in_days: 1.0
  },
  {
    title: "日記をつける",
    description: "その日を振り返りながら簡単な日記をつける",
    category: "Journaling",
    frequency_number: 1, frequency_unit: "日", frequency_in_days: 1.0
  },
  {
    title: "本を10ページ読む",
    description: "読書習慣の維持のため毎日少しずつ読む",
    category: "Reading",
    frequency_number: 1, frequency_unit: "日", frequency_in_days: 1.0
  },
  {
    title: "洗濯する",
    description: "衣類の清潔を保つために定期的に洗濯",
    category: "Tidying Up",
    frequency_number: 1, frequency_unit: "日", frequency_in_days: 1.0
  },
  {
    title: "部屋の掃除",
    description: "週末に部屋を掃除して整える",
    category: "Decluttering",
    frequency_number: 1, frequency_unit: "日", frequency_in_days: 1.0
  },
  {
    title: "朝のニュース確認",
    description: "毎朝ニュースを確認して時事問題に敏感になる",
    category: "Skill Development",
    frequency_number: 1, frequency_unit: "日", frequency_in_days: 1.0
  },
  {
    title: "水を2L飲む",
    description: "健康のためにこまめに水分補給を行う",
    category: "Balanced Diet",
    frequency_number: 1, frequency_unit: "日", frequency_in_days: 1.0
  },
  {
    title: "貯金をする",
    description: "お金を貯めて旅行に行く",
    category: "Saving",
    frequency_number: 1, frequency_unit: "日", frequency_in_days: 1.0
  }
]

colors = %w[orange blue green yellow yellowgreen red]

today = Date.today

task_templates.each_with_index do |template, i|
  task = demo_user.tasks.create!(
    title: template[:title],
    description: template[:description],
    category: template[:category],
    frequency: "custom",
    frequency_number: template[:frequency_number],
    frequency_unit: template[:frequency_unit],
    frequency_in_days: template[:frequency_in_days],
    start_date: today - rand(7..14),
    end_date: today + rand(14..60),
    color: colors[i % colors.length],
    message: "#{template[:title]}を実行して気持ちよく一日を始めよう！"
  )

  log_count = rand(2..5)
  may_days = (Date.new(2025,5,1)..Date.new(2025,5,31)).to_a
  log_days = may_days.sample(log_count)
  
  log_days.each do |day|
    task_log = task.task_logs.new(executed_on: day)
    unless task_log.save
      puts "Failed to save task_log for task id=#{task.id}, executed_on=#{day}"
      puts task_log.errors.full_messages
    end
  end 
end

completed_tasks = demo_user.tasks.limit(5)

completed_tasks.each do |task|
  valid_days = (task.start_date..Date.today + 10).to_a
  future_days = valid_days.sample([5, valid_days.size].min)

  future_days.each do |day|
    task_log = task.task_logs.new(executed_on: day)
    unless task_log.save
      puts "Failed to save completed task_log for task id=#{task.id}, executed_on=#{day}"
      puts task_log.errors.full_messages
    end
  end
end

puts "📌 10 realistic demo tasks and task_logs created"
puts "🎉 Seed completed for demo user"
