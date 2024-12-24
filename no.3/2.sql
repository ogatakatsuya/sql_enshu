SELECT c.title, s.name
FROM course c
JOIN registration r ON c.code = r.code
JOIN student s ON r.number = s.number
WHERE c.room IS NULL;

db.cs.aggregate([
    {
        $match: { room: null }
    },
    {
        $lookup: {
            from: "rg",
            localField: "code",
            foreignField: "code",
            as: "registrations"
        }
    },
    {
        $unwind: "$registrations"
    },
    {
        $lookup: {
            from: "st",
            localField: "registrations.number",
            foreignField: "number",
            as: "student"
        }
    },
    {
        $unwind: "$student"
    },
    {
        $project: {
            title: 1,
            "student_name": "$student.name"
        }
    }
]);

coursedb> ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... [
  {
    _id: ObjectId('6396a971fe5b9b982a144c85'),
    title: 'Thesis Work',
    student_name: 'Aomori'
  },
  {
    _id: ObjectId('6396a971fe5b9b982a144c85'),
    title: 'Thesis Work',
    student_name: 'Akita'
  },
  {
    _id: ObjectId('6396a971fe5b9b982a144c85'),
    title: 'Thesis Work',
    student_name: 'Iwate'
  },
  {
    _id: ObjectId('6396a971fe5b9b982a144c85'),
    title: 'Thesis Work',
    student_name: 'Yamagata'
  },
  {
    _id: ObjectId('6396a971fe5b9b982a144c85'),
    title: 'Thesis Work',
    student_name: 'Miyagi'
  }
]