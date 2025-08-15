import { internships, type internship } from '../data/internships';


export const Experience = () => {
  return (
    <section id="experience" className="pb-24 bg-teal-700">
      {/* Section Header */}
      <div className="w-full bg-teal-600 py-4 px-8 mb-8">
        <h2 className="text-3xl font-bold text-white uppercase tracking-wide">Experience</h2>
      </div>

      {/* Section Content */}
      <div className="max-w-5xl mx-auto px-8">
        <div className="bg-gray-100 p-8 rounded-lg">
          <div className="space-y-8">
            {internships.map((internship: internship, index) => {
              return (
                <div
                  key={index}
                  className="bg-white rounded-xl p-8 shadow-sm border border-gray-200 hover:shadow-md transition-shadow duration-200"
                >
                  {/* Header with company and role */}
                  <div className="flex justify-between items-center mb-3">
                    <h2 className="text-2xl font-bold text-gray-900">{internship.company}</h2>
                    <h3 className="text-xl font-semibold text-gray-700 text-right">{internship.role}</h3>
                  </div>

                  {/* Duration */}
                  <p className="text-teal-600 font-medium mb-4">{internship.duration}</p>

                  {/* Separator line */}
                  <div className="border-t border-gray-200 mb-6"></div>

                  {/* Job description */}
                  {internship.jobDescription.map((item, index) => (
                    <div key={index} className="flex my-2">
                      <div className="w-2 h-2 bg-teal-500 rounded-full mt-2 mr-3 flex-shrink-0"></div>
                      <p className="text-gray-700 leading-relaxed font-medium">{item}</p>
                    </div>
                  ))}

                  {/* Tools */}
                  <div key={index} className="flex items-start">
                    <div className="w-2 h-2 bg-teal-500 rounded-full mt-2 mr-3 flex-shrink-0"></div>
                    <p className="text-gray-700 leading-relaxed font-medium">
                      <b>Tools: </b>
                      {internship.tools}
                    </p>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </section>
  );
};
