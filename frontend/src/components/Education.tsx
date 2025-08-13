export const Education = () => {
  return (
    <section id="education" className="pb-24">
      {/* Section Header */}
      <div className="w-full bg-teal-600 py-4 px-8 mb-8">
        <h2 className="text-3xl font-bold text-white uppercase tracking-wide">Education</h2>
      </div>

      {/* Section Content */}
      <div className="max-w-5xl mx-auto px-8">
        <div className="bg-gray-100 p-8 rounded-lg">
          <div className="space-y-6">
            <div className="bg-white rounded-lg p-6 shadow-sm">
              <h3 className="text-2xl font-semibold text-gray-800 mb-2">National University of Singapore (NUS)</h3>
              <p className="text-teal-600 mb-2">Bachelor of Computer Science • 2022 - current</p>
              <p className="text-gray-700 mb-3">
                <li>Specialised in software engineering and database systems</li>
              </p>
              <div className="flex gap-2">
                <span className="px-3 py-1 bg-teal-600 text-white rounded-full text-sm">Data Structures</span>
                <span className="px-3 py-1 bg-teal-600 text-white rounded-full text-sm">Algorithms</span>
                <span className="px-3 py-1 bg-teal-600 text-white rounded-full text-sm">Software Engineering</span>
              </div>
            </div>
            <div className="bg-white rounded-lg p-6 shadow-sm">
              <h3 className="text-2xl font-semibold text-gray-800 mb-2">2nd Singapore Infrantry Regiment (2SIR)</h3>
              <p className="text-teal-600 mb-2">3rd Sergeant • 2020-2021</p>
              <p className="text-gray-700 mb-3">
                <li>Served in National Service</li>
              </p>
            </div>
            <div className="bg-white rounded-lg p-6 shadow-sm">
              <h3 className="text-2xl font-semibold text-gray-800 mb-2">Hwa Chong Institution</h3>
              <p className="text-teal-600 mb-2">'A' level certificate • 2014-2019</p>
              <p className="text-gray-700 mb-3">
                <li>Graduated with Hwa Chong Diploma</li>
              </p>
            </div>
            {/* <div className="bg-white rounded-lg p-6 shadow-sm">
                      <h3 className="text-2xl font-semibold text-gray-800 mb-2">
                        Certifications
                      </h3>
                      <div className="space-y-2 text-gray-700">
                        <p>• AWS Certified Developer Associate</p>
                        <p>• Python Institute Certified Python Programmer</p>
                        <p>• MongoDB Certified Developer</p>
                      </div>
                    </div> */}
          </div>
        </div>
      </div>
    </section>
  );
};
