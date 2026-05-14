module RecipesHelper
  def difficulty_badge(recipe)
    css_class = case recipe.difficulty
                when "easy" then "badge bg-success"
                when "medium" then "badge bg-warning text-dark"
                when "hard" then "badge bg-danger"
                else "badge bg-secondary"
                end

    content_tag(:span, recipe.difficulty, class: css_class)
  end
end
