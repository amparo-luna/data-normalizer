require './services/data.rb'

def normalize_data(input)
  Services::Data.(input)
end

examples = [
  # To-be normalized data                                                           # Normalized data
  [{ :year => '2018', :make => 'fo',      :model => 'focus',    :trim => 'blank' }, { :year => 2018,  :make => 'Ford',      :model => 'Focus',  :trim => nil }],
  [{ :year => '200',  :make => 'blah',    :model => 'foo',      :trim => 'bar' },   { :year => '200', :make => 'blah',      :model => 'foo',    :trim => 'bar' }],
  [{ :year => '1999', :make => 'Chev',    :model => 'IMPALA',   :trim => 'st' },    { :year => 1999,  :make => 'Chevrolet', :model => 'Impala', :trim => 'ST' }],
  [{ :year => '2000', :make => 'ford',    :model => 'focus se', :trim => '' },      { :year => 2000,  :make => 'Ford',      :model => 'Focus',  :trim => 'SE' }]
]

examples.each_with_index do |(input, expected_output), index|
  output = normalize_data(input)

  if output != expected_output
    puts "Example #{index + 1} failed,
          Expected: #{expected_output.inspect}
          Got:      #{output.inspect}"

  else
    puts "Case #{index + 1}: succes!"
  end
end
