import { useState } from 'react';
import { Github, Eye, Database, Zap, Globe } from 'lucide-react';
import { SiLeetcode } from 'react-icons/si';
import { scrollToSection } from '../utils/util';
import type { VisitorCountLoadingState } from '../App';

export const About = ({ visitorCount }: { visitorCount: VisitorCountLoadingState | number }) => {
  const [isFlipped, setIsFlipped] = useState(false);

  return (
    <section id="about" className="pb-24 bg-teal-700">
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

              {/* Flipping Visitor Counter */}
              <div className="bg-white rounded-xl shadow-lg border border-gray-200 max-w-md perspective-1000">
                <div
                  className={`relative w-full h-32 transition-transform duration-700 transform-style-preserve-3d ${
                    isFlipped ? 'rotate-y-180' : ''
                  }`}
                >
                  {/* Front Side - Visitor Counter */}
                  <div className="absolute inset-0 w-full h-full backface-hidden p-6">
                    <div className="flex items-center gap-4 h-full">
                      <button
                        onClick={() => {
                          if (typeof visitorCount === 'number') {
                            setIsFlipped(!isFlipped);
                          }
                        }}
                        className={`p-3 bg-teal-100 rounded-full transition-colors duration-200 ${
                          typeof visitorCount === 'number' ? 'hover:bg-teal-200 cursor-pointer' : ''
                        }`}
                      >
                        <Eye className="w-8 h-8 text-teal-600" />
                      </button>
                      <div>
                        {typeof visitorCount === 'number' ? (
                          <div className="text-gray-600 text-lg font-medium flex items-center">
                            You are my
                            <div className="text-3xl font-bold text-gray-800 mx-2">
                              #{visitorCount.toLocaleString()}
                            </div>
                            visitor!
                          </div>
                        ) : (
                          <div className="text-3xl font-bold text-gray-800">{visitorCount}</div>
                        )}
                      </div>
                    </div>
                  </div>

                  {/* Back Side - AWS Tech Stack */}
                  <div className="absolute inset-0 w-full h-full backface-hidden rotate-y-180 p-6 bg-gradient-to-r from-orange-50 to-blue-50">
                    <div className="h-full flex flex-col justify-center">
                      <button
                        onClick={() => setIsFlipped(!isFlipped)}
                        className="absolute top-3 right-3 p-2 text-gray-500 hover:text-gray-700 transition-colors cursor-pointer"
                      >
                        <Eye className="w-6 h-6" />
                      </button>

                      <div className="text-center">
                        <p className="text-gray-700 text-sm font-medium mb-3">Your visit is recorded using:</p>

                        <div className="flex justify-center items-center gap-3">
                          <div className="flex flex-col items-center">
                            <Globe className="w-6 h-6 text-green-600 mb-1" />
                            <span className="text-xs font-bold text-green-700">API Gateway</span>
                          </div>

                          <div className="text-gray-400">→</div>

                          <div className="flex flex-col items-center">
                            <Zap className="w-6 h-6 text-orange-500 mb-1" />
                            <span className="text-xs font-bold text-orange-600">Lambda</span>
                          </div>

                          <div className="text-gray-400">→</div>

                          <div className="flex flex-col items-center">
                            <Database className="w-6 h-6 text-blue-600 mb-1" />
                            <span className="text-xs font-bold text-blue-700">DynamoDB</span>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            {/* Skills Section */}
            <div className="space-y-4">
              <div>
                <span className="font-semibold text-gray-800">Languages:</span>
                <span className="text-gray-700 ml-2">Python, Java, TypeScript</span>
              </div>
              <div>
                <span className="font-semibold text-gray-800">Databases:</span>
                <span className="text-gray-700 ml-2">PostgreSQL, MongoDB</span>
              </div>
              <div>
                <span className="font-semibold text-gray-800">Libraries:</span>
                <span className="text-gray-700 ml-2">Zod, Axios, Socket.IO, Mongoose</span>
              </div>
              <div>
                <span className="font-semibold text-gray-800">Frameworks:</span>
                <span className="text-gray-700 ml-2">Tailwind, ExpressJS, SpringBoot</span>
              </div>
              <div>
                <span className="font-semibold text-gray-800">Tools & Technologies:</span>
                <span className="text-gray-700 ml-2">Git, Docker, AWS, Terraform, GitHub Actions</span>
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
                onClick={() => scrollToSection('experience')}
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
