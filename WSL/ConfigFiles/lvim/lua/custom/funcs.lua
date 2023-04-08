local M = {}

-- # Show docker logs
M.docker_logs = function(docker_cont_name)
  return "docker logs " .. docker_cont_name .. " --follow"
end

-- # Enter into docker container
M.docker_exec = function(docker_cont_name)
  return "docker exec -it " .. docker_cont_name .. " /bin/bash"
end

return M
