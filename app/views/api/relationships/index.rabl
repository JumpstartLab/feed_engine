collection @relationships

node(:follower) { |relationship| relationship["follower"] }
node(:followed) { |relationship| relationship["followed"] }
node(:since_id)  { |relationship| relationship["last_id"] }
