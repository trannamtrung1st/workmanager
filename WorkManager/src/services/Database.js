const Database = {
  tasks: [
    {
      id: 1,
      name: "Làm việc nhóm",
      source_id: 3,
      source: {
        id: 3,
        name: "Làm việc nhóm cũ"
      },
      task_content: "Làm việc nhóm cho xong hết cmnd",
      task_report: "Vừa mới làm được có chút xíu. ôi thôi dm",
      manager_review: "Làm tốt lắm e ei",
      mark: 9,
      review_time: "2011-10-10T14:48:00",
      start_time: "2011-10-10T14:48:00",
      end_time: "2011-10-10T14:48:00",
      deadline: "2011-10-10T14:48:00",
      status: "NEW",
      created_time: "2011-10-10T14:48:00",
      created_user: "trannamtrung1st",
      of_user: "trannamtrung1st",
      confirm_image:
        "https://www.instamobile.io/wp-content/uploads/2018/10/Screen-Shot-2018-10-25-at-10.09.07-PM.png"
    },
    {
      id: 2,
      name: "Làm bài tập",
      source_id: 3,
      source: {
        id: 3,
        name: "Làm việc nhóm cũ"
      },
      task_content: "Làm việc nhóm cho xong hết cmnd",
      task_report: "Vừa mới làm được có chút xíu. ôi thôi dm",
      manager_review: "Làm tốt lắm e ei",
      mark: 8,
      review_time: "2011-10-10T14:48:00",
      start_time: "2011-10-10T14:48:00",
      end_time: "2011-10-10T14:48:00",
      deadline: "2011-10-10T14:48:00",
      status: "DOING",
      created_time: "2011-10-10T14:48:00",
      created_user: "trannamtrung2nd",
      of_user: "trannamtrung2nd",
      confirm_image:
        "https://www.instamobile.io/wp-content/uploads/2018/10/Screen-Shot-2018-10-25-at-10.09.07-PM.png"
    }
  ],
  users: [
    {
      id: "1",
      username: "trannamtrung1st",
      email: "trannamtrung1st@gmail.com",
      phone_number: "0152925215",
      full_name: "Trần Nam Trung",
      employee_code: "EMP0012425",
      roles: ["User"]
    },
    {
      id: "2",
      username: "trannamtrung2nd",
      email: "trannamtrung2nd@gmail.com",
      phone_number: "0152925215",
      full_name: "Trần Nam Trung",
      employee_code: "EMP0012524",
      roles: ["Manager"]
    },
    {
      id: "J",
      username: "trannamtrung2nd",
      email: "trannamtrung2nd@gmail.com",
      phone_number: "0152925215",
      full_name: "Trần Nam Trung",
      employee_code: "EMP0012524",
      roles: ["Manager"]
    },
    {
      id: "H",
      username: "trannamtrung2nd",
      email: "trannamtrung2nd@gmail.com",
      phone_number: "0152925215",
      full_name: "Trần Nam Trung",
      employee_code: "EMP0012524",
      roles: ["Manager"]
    },
    {
      id: "G",
      username: "trannamtrung2nd",
      email: "trannamtrung2nd@gmail.com",
      phone_number: "0152925215",
      full_name: "Trần Nam Trung",
      employee_code: "EMP0012524",
      roles: ["Manager"]
    },
    {
      id: "F",
      username: "trannamtrung2nd",
      email: "trannamtrung2nd@gmail.com",
      phone_number: "0152925215",
      full_name: "Trần Nam Trung",
      employee_code: "EMP0012524",
      roles: ["Manager"]
    },
    {
      id: "E",
      username: "trannamtrung2nd",
      email: "trannamtrung2nd@gmail.com",
      phone_number: "0152925215",
      full_name: "Trần Nam Trung",
      employee_code: "EMP0012524",
      roles: ["Manager"]
    },
    {
      id: "D",
      username: "trannamtrung2nd",
      email: "trannamtrung2nd@gmail.com",
      phone_number: "0152925215",
      full_name: "Trần Nam Trung",
      employee_code: "EMP0012524",
      roles: ["Manager"]
    },
    {
      id: "C",
      username: "trannamtrung2nd",
      email: "trannamtrung2nd@gmail.com",
      phone_number: "0152925215",
      full_name: "Trần Nam Trung",
      employee_code: "EMP0012524",
      roles: ["Manager"]
    },
    {
      id: "B",
      username: "trannamtrung2nd",
      email: "trannamtrung2nd@gmail.com",
      phone_number: "0152925215",
      full_name: "Trần Nam Trung",
      employee_code: "EMP0012524",
      roles: ["Manager"]
    },
    {
      id: "A",
      username: "trannamtrung2nd",
      email: "trannamtrung2nd@gmail.com",
      phone_number: "0152925215",
      full_name: "Trần Nam Trung",
      employee_code: "EMP0012524",
      roles: ["Manager"]
    }
  ],
  groups: [
    {
      id: 1,
      name: "Group thứ nhất",
      description: "Đây là mô tả của group 1",
      created_time: "2011-10-10T14:48:00",
      created_user: "trannamtrung1st"
    },
    {
      id: 2,
      name: "Group thứ hai",
      description: "Đây là mô tả của group 2",
      created_time: "2011-10-10T14:48:00",
      created_user: "trannamtrung2nd"
    }
  ]
};
export default Database;
