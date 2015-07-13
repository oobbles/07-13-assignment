# Load/create our database for this program.
CONNECTION = SQLite3::Database.new("work.db")

# Make the tables.
CONNECTION.execute("CREATE TABLE IF NOT EXISTS assignments (id INTEGER PRIMARY KEY, description TEXT UNIQUE);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS links (id INTEGER PRIMARY KEY, link TEXT UNIQUE);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS collabs (id INTEGER PRIMARY KEY, name TEXT UNIQUE);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS assignments_links (assignment_id INTEGER, link_id INTEGER);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS assignments_collabs (assignment_id INTEGER, collab_id INTEGER);")
# Get results as an Array of Hashes.
CONNECTION.results_as_hash = true
