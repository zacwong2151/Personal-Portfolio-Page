import { FileText } from 'lucide-react';

export const Resume = () => {
  return (
    <section id="resume" className="pb-96">
      {/* Section Header */}
      <div className="w-full bg-teal-600 py-4 px-8 mb-8">
        <h2 className="text-3xl font-bold text-white uppercase tracking-wide">Resume</h2>
      </div>

      {/* Section Content */}
      <div className="max-w-5xl mx-auto px-8">
        <div className="bg-gray-100 p-8 rounded-lg">
          <div className="bg-white rounded-lg p-8 text-center shadow-sm">
            <div className="mb-6">
              <FileText className="w-16 h-16 text-teal-600 mx-auto mb-4" />
              <h3 className="text-2xl font-semibold text-gray-800 mb-2">Download My Resume</h3>
              <p className="text-gray-700 mb-6">
                Get a comprehensive overview of my experience, skills, and qualifications.
              </p>
            </div>
            <div className="flex gap-4 justify-center">
              <button className="px-6 py-3 bg-teal-600 text-white rounded hover:bg-teal-700 transition-colors font-medium flex items-center gap-2">
                <FileText className="w-5 h-5" />
                Download PDF
              </button>
              <button className="px-6 py-3 border-2 border-teal-600 text-teal-600 rounded hover:bg-teal-600 hover:text-white transition-colors font-medium">
                View Online
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};
