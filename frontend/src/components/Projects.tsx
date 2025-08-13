import { Github, ExternalLink } from 'lucide-react';
import { projects } from '../data/projects';

export const Projects = () => {
  return (
    <section id="projects" className="pb-24">
      {/* Section Header */}
      <div className="w-full bg-teal-600 py-4 px-8 mb-8">
        <h2 className="text-3xl font-bold text-white uppercase tracking-wide">Projects</h2>
      </div>

      {/* Section Content */}
      <div className="max-w-5xl mx-auto px-8">
        <div className="bg-gray-100 p-8 rounded-lg">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {projects.map((project) => (
              <div
                key={project.id}
                className="bg-white rounded-lg shadow-sm overflow-hidden hover:shadow-md transition-shadow duration-200 flex flex-col"
              >
                {/* Image Section */}
                <div className="w-full h-50 bg-gray-200 overflow-hidden">
                  <img
                    src={project.image}
                    alt={`${project.title} Logo`}
                    className="w-full h-full object-cover hover:scale-105 transition-transform duration-200"
                  />
                </div>

                {/* Content Section - Flex grow to fill available space */}
                <div className="py-7 px-6 pt-5 flex flex-col flex-1">
                  {/* Header with title and links */}
                  <div className="flex justify-between items-center mb-3">
                    <h3 className="text-xl font-semibold text-gray-800">{project.title}</h3>
                    <div className="flex gap-2 ml-4">
                      {/* GitHub Link */}
                      <a
                        href={project.githubUrl}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="p-2 text-gray-600 hover:text-gray-900 hover:bg-gray-100 rounded-full transition-colors duration-200"
                        title="View on GitHub"
                      >
                        <Github size={22} />
                      </a>

                      {/* Live Site Link (only if available) */}
                      {project.liveUrl && (
                        <a
                          href={project.liveUrl}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="p-2 text-gray-600 hover:text-teal-600 hover:bg-teal-50 rounded-full transition-colors duration-220"
                          title="Visit Live Site"
                        >
                          <ExternalLink size={22} />
                        </a>
                      )}
                    </div>
                  </div>

                  {/* Description - Grows to fill available space */}
                  <p className="text-gray-700 mb-4 leading-relaxed flex-1">{project.description}</p>

                  {/* Technology Tags - Always at bottom */}
                  <div className="flex flex-wrap gap-2 mt-auto">
                    {project.technologies.map((tech, index) => (
                      <span key={index} className="px-3 py-1 bg-teal-600 text-white rounded-full text-sm font-medium">
                        {tech}
                      </span>
                    ))}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
};
