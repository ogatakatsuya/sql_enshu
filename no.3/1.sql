SELECT c.title, COUNT(r.number) AS student_count
FROM course c
JOIN registration r ON c.code = r.code
GROUP BY c.code, c.title
HAVING COUNT(r.number) <= 5;

db.cs.aggregate([
    {
        $lookup: {
            from: "rg",
            localField: "code",
            foreignField: "code",
            as: "registrations"
        }
    },
    {
        $project: {
            title: 1,
            student_count: { $size: "$registrations" }
        }
    },
    {
        $match: { student_count: { $lte: 5 } }
    }
]);

coursedb> ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... [
  {
    _id: ObjectId('6396a971fe5b9b982a144c85'),
    title: 'Thesis Work',
    student_count: 5
  },
  {
    _id: ObjectId('6396a971fe5b9b982a144c8d'),
    title: 'Data Science',
    student_count: 5
  },
  {
    _id: ObjectId('6396a971fe5b9b982a144c8e'),
    title: 'Knowledge Engineering',
    student_count: 5
  },
  {
    _id: ObjectId('6572e7eb471e65bfb4051ad1'),
    title: 'Computer Science Basics',
    student_count: 2
  },
  {
    _id: ObjectId('6572e7eb471e65bfb4051ad2'),
    title: 'Bio-Engineering Intro',
    student_count: 2
  }
]