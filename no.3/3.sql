SELECT c.title, r.grade, s.name
FROM course c
JOIN registration r ON c.code = r.code
JOIN student s ON r.number = s.number
WHERE c.type = 'R'
AND r.grade = (
    SELECT MAX(r1.grade)
    FROM registration r1
    WHERE r1.code = c.code
);

db.cs.aggregate([
    {
        $match: { type: "R" }
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
        $group: {
            _id: "$code",
            title: { $first: "$title" },
            max_grade: { $max: "$registrations.grade" },
            students: {
                $push: {
                    grade: "$registrations.grade",
                    name: "$student.name"
                }
            }
        }
    },
    {
        $project: {
            title: 1,
            max_grade: 1,
            student_names: {
                $filter: {
                    input: "$students",
                    as: "student",
                    cond: { $eq: ["$$student.grade", "$max_grade"] }
                }
            }
        }
    }
]);

coursedb> ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... ... [
  {
    _id: 'C03',
    title: 'Database',
    max_grade: 97,
    student_names: [ { grade: 97, name: 'America' } ]
  },
  {
    _id: 'C02',
    title: 'Computer Architecture',
    max_grade: 98,
    student_names: [ { grade: 98, name: 'Yamagata' } ]
  },
  {
    _id: 'C01',
    title: 'Programming',
    max_grade: 99,
    student_names: [ { grade: 99, name: 'Miyagi' } ]
  },
  {
    _id: 'C04',
    title: 'Thesis Work',
    max_grade: 96,
    student_names: [ { grade: 96, name: 'Aomori' } ]
  }
]