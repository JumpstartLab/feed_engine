collection @relationships

node(:follower) { |relationship| relationship["follower"] }
node(:follower_token) { |relationship| relationship["follower_token"]}
node(:followed) { |relationship| relationship["followed"] }
node(:since_id)  { |relationship| relationship["last_id"] }
