require 'securerandom'
require 'base64'

def uuidv4_pattern
  /[0-9a-f]{8}-[0-9a-f]{4}-[4][0-9a-f]{3}-[8-9a-b][0-9a-f]{3}-[0-9a-f]{12}/
end

# hash keys to symbols
def deep_symbolize_hash(obj)
  return obj.reduce({}) do |memo, (k, v)|
    memo.tap { |m| m[k.to_sym] = deep_symbolize_hash(v) }
  end if obj.is_a? Hash

  return obj.reduce([]) do |memo, v|
    memo << deep_symbolize_hash(v); memo
  end if obj.is_a? Array

  obj
end

# hash keys to string
def deep_stringify_hash(obj)
  return obj.reduce({}) do |memo, (k, v)|
    memo.tap { |m| m[k.to_s] = deep_stringify_hash(v) }
  end if obj.is_a? Hash

  return obj.reduce([]) do |memo, v|
    memo << deep_stringify_hash(v); memo
  end if obj.is_a? Array

  obj
end

def symbolize_hash(hash)
  JSON.parse(hash.to_json, :symbolize_names => true)
end

def generate_uuidv4
  SecureRandom.uuid
end


def base64(token)
  Digest::MD5.base64digest(token)
end

def new_string(n=600)
  chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
  result = ""
  1.upto(n) { |i| result << chars[rand(chars.size-1)] }
  result
end
