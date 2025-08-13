import { Github, Eye } from 'lucide-react';
import { SiLeetcode } from 'react-icons/si';
import { scrollToSection } from '../utils/util';
import type { VisitorCountLoadingState } from '../App';

export const About = ({
  visitorCount,
}: {
  visitorCount: VisitorCountLoadingState | number;
}) => {
  return (
    <section id="about" className="pb-24">
      {/* Section Header */}
      <div className="w-full bg-teal-600 py-4 px-8 mb-8">
        <h2 className="text-3xl font-bold text-white uppercase tracking-wide">About</h2>
      </div>

      {/* Section Content */}
      <div className="max-w-5xl mx-auto px-8">
        <div className="bg-gray-100 p-8 rounded-lg">
          <div className="space-y-8">
            {/* Welcome Message */}
            <div>
              <h1 className="text-5xl font-bold text-gray-800 mb-4">
                Hi, I'm <span className="bg-teal-600 px-4 py-2 rounded text-white">Zac.</span>
              </h1>

              <p className="text-lg text-gray-700 leading-relaxed pt-4 mb-6">
                I am a Computer Science undergraduate at National University of Singapore. This is my personal portfolio
                page hosted using AWS CloudFront and S3, hope it is nice to look at!
              </p>

              {/* Big Prominent Visitor Counter */}
              <div className="bg-white rounded-xl p-6 shadow-lg border border-gray-200 max-w-md">
                <div className="flex items-center gap-4">
                  <div className="p-3 bg-teal-100 rounded-full">
                    <Eye className="w-8 h-8 text-teal-600" />
                  </div>
                  <div>
                    {typeof visitorCount === 'number' ? (
                      <div className="text-gray-600 text-lg font-medium flex items-center">
                        You are my
                        <div className="text-3xl font-bold text-gray-800 mx-2">#{visitorCount.toLocaleString()}</div>
                        visitor!
                      </div>
                    ) : (
                      <div className="text-3xl font-bold text-gray-800">{visitorCount}</div>
                    )}
                  </div>
                </div>
              </div>
            </div>

            {/* Skills Section */}
            <div className="space-y-4">
              <div>
                <span className="font-semibold text-gray-800">Languages:</span>
                <span className="text-gray-700 ml-2">Python, Java, JavaScript, HTML/CSS</span>
              </div>
              <div>
                <span className="font-semibold text-gray-800">Databases:</span>
                <span className="text-gray-700 ml-2">PostgreSQL, MongoDB</span>
              </div>
              <div>
                <span className="font-semibold text-gray-800">Libraries:</span>
                <span className="text-gray-700 ml-2"></span>
              </div>
              <div>
                <span className="font-semibold text-gray-800">Frameworks:</span>
                <span className="text-gray-700 ml-2">Node.js, Tailwind</span>
              </div>
              <div>
                <span className="font-semibold text-gray-800">Tools & Technologies:</span>
                <span className="text-gray-700 ml-2">Git, Docker, AWS</span>
              </div>
            </div>

            {/* Social Links */}
            <div className="flex gap-4 items-center">
              <a href="https://github.com/zacwong2151" target="_blank" rel="noopener noreferrer">
                <button className="p-3 bg-gray-800 hover:bg-gray-700 rounded-full transition-colors hover:cursor-pointer">
                  <Github className="w-6 h-6 text-white" />
                </button>
              </a>
              <a href="https://leetcode.com/u/zacwong2151/" target="_blank" rel="noopener noreferrer">
                <button className="p-3 bg-gray-800 hover:bg-gray-700 rounded-full transition-colors hover:cursor-pointer">
                  <SiLeetcode className="w-6 h-6 text-white" />
                </button>
              </a>
            </div>

            {/* Action Buttons */}
            <div className="flex gap-4">
              <button
                className="px-6 py-3 bg-teal-600 text-white rounded hover:bg-teal-700 transition-colors font-medium hover:cursor-pointer"
                onClick={() => {
                  console.log('here');
                  scrollToSection('experience');
                }}
              >
                Read More
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};
