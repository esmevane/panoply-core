remove_label = -> label do
  """
update  labels
set     content = (select array_agg(x)
                   from (select unnest(content) as x) sq_1
                   where not x = '#{label}')
where   content @> '{#{label}}'
  """
end

add_label = -> label do
  """
update labels
set    content = array_append(content, '#{label}')
  """
end