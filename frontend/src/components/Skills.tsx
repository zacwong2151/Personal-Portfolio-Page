export const Skills = () => {
  return (
    <section id="skills" className="pb-24">
      {/* Section Header */}
      <div className="w-full bg-teal-600 py-4 px-8 mb-8">
        <h2 className="text-3xl font-bold text-white uppercase tracking-wide">Skills</h2>
      </div>

      {/* Section Content */}
      <div className="max-w-5xl mx-auto px-8">
        <div className="bg-gray-100 p-8 rounded-lg">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div>
              <h3 className="text-2xl font-semibold text-gray-800 mb-4">Programming Languages</h3>
              <div className="space-y-4">
                <div>
                  <div className="flex justify-between text-gray-800 mb-1">
                    <span>Python</span>
                    <span>90%</span>
                  </div>
                  <div className="w-full bg-gray-300 rounded-full h-2">
                    <div className="bg-teal-600 h-2 rounded-full" style={{ width: '90%' }}></div>
                  </div>
                </div>
                <div>
                  <div className="flex justify-between text-gray-800 mb-1">
                    <span>JavaScript</span>
                    <span>80%</span>
                  </div>
                  <div className="w-full bg-gray-300 rounded-full h-2">
                    <div className="bg-teal-600 h-2 rounded-full" style={{ width: '80%' }}></div>
                  </div>
                </div>
                <div>
                  <div className="flex justify-between text-gray-800 mb-1">
                    <span>SQL</span>
                    <span>85%</span>
                  </div>
                  <div className="w-full bg-gray-300 rounded-full h-2">
                    <div className="bg-teal-600 h-2 rounded-full" style={{ width: '85%' }}></div>
                  </div>
                </div>
              </div>
            </div>
            <div>
              <h3 className="text-2xl font-semibold text-gray-800 mb-4">Frameworks & Tools</h3>
              <div className="flex flex-wrap gap-2 mb-6">
                <span className="px-3 py-1 bg-teal-600 text-white rounded-full">Django</span>
                <span className="px-3 py-1 bg-teal-600 text-white rounded-full">Flask</span>
                <span className="px-3 py-1 bg-teal-600 text-white rounded-full">FastAPI</span>
                <span className="px-3 py-1 bg-teal-600 text-white rounded-full">React</span>
                <span className="px-3 py-1 bg-teal-600 text-white rounded-full">PostgreSQL</span>
                <span className="px-3 py-1 bg-teal-600 text-white rounded-full">MongoDB</span>
                <span className="px-3 py-1 bg-teal-600 text-white rounded-full">Docker</span>
                <span className="px-3 py-1 bg-teal-600 text-white rounded-full">Git</span>
              </div>
              <h3 className="text-2xl font-semibold text-gray-800 mb-4">Databases</h3>
              <div className="space-y-4">
                <div>
                  <div className="flex justify-between text-gray-800 mb-1">
                    <span>PostgreSQL</span>
                    <span>85%</span>
                  </div>
                  <div className="w-full bg-gray-300 rounded-full h-2">
                    <div className="bg-teal-600 h-2 rounded-full" style={{ width: '85%' }}></div>
                  </div>
                </div>
                <div>
                  <div className="flex justify-between text-gray-800 mb-1">
                    <span>MongoDB</span>
                    <span>75%</span>
                  </div>
                  <div className="w-full bg-gray-300 rounded-full h-2">
                    <div className="bg-teal-600 h-2 rounded-full" style={{ width: '75%' }}></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};
