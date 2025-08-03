require("configs")

function R(name)
  package.loaded[name] = nil
  return require(name)
end
