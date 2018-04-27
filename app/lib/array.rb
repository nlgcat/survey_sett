class Array
  # Return a number of elements from the array which must include the target
  def sample_including(target, ommit = [], number = 4)
    # TODO - This works for arrays which are comparible only, need to use map or something
    answers = (self - ommit).sample(number)
    answers = answers.sample(3) << target.name unless answers.include?(target.name)
    answers.sort
  end
end