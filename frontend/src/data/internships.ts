type internship = {
  company: string;
  role: string;
  duration: string;
  jobDescription: string[];
  tools: string;
};

export const internships: internship[] = [
  {
    company: 'OCBC',
    role: 'Product Developer intern',
    duration: 'Jan 2025 - June 2025',
    jobDescription: [
      "Conduct end-to-end testing for OCBC's loan origination system",
      'Analysed product requirements and created test cases to conduct comprehensive testing',
      'Write Python scripts to automate the generation of customer-facing PDFs',
      'Write Excel macros to extract relevant data from the wealth management team and derive business insights',
    ],
    tools: 'Python, Microsoft VBA',
  },
  {
    company: 'Maritime & Port Authority of Singapore',
    role: 'Software Developer intern',
    duration: 'May 2024 - July 2024',
    jobDescription: [
      'Developed REST APIs for the submission of data by ship vessels and persistent storage into a backend database',
      'Worked on frontend API integration',
      'Worked on authentication of API requests to ensure internal security',
    ],
    tools: 'SpringBoot, Java, Git, MySQL',
  },
];
