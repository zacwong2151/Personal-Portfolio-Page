import { Mail, Linkedin, Github } from 'lucide-react';

export const Contact = () => {
  return (
    <section id="contact" className="pb-24">
      {/* Section Header */}
      <div className="w-full bg-teal-600 py-4 px-8 mb-8">
        <h2 className="text-3xl font-bold text-white uppercase tracking-wide">Contact</h2>
      </div>

      {/* Section Content */}
      <div className="max-w-5xl mx-auto px-8">
        <div className="bg-gray-100 p-8 rounded-lg">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div className="bg-white rounded-lg p-6 shadow-sm">
              <h3 className="text-xl font-semibold text-gray-800 mb-4">Get in Touch</h3>
              <div className="space-y-3 text-gray-700">
                <p className="flex items-center gap-2">
                  <Mail className="w-5 h-5" />
                  zacwong2151@gmail.com
                </p>
                <p className="flex items-center gap-2">📱 +65 9666 5586</p>
                <p className="flex items-center gap-2">📍 Singapore</p>
              </div>
              <div className="flex gap-4 items-center mt-6">
                <button className="p-3 bg-blue-600 hover:bg-blue-700 rounded-full transition-colors">
                  <Linkedin className="w-6 h-6 text-white" />
                </button>
                <button className="p-3 bg-gray-800 hover:bg-gray-700 rounded-full transition-colors">
                  <Github className="w-6 h-6 text-white" />
                </button>
              </div>
            </div>
            <div className="bg-white rounded-lg p-6 shadow-sm">
              <h3 className="text-xl font-semibold text-gray-800 mb-4">Send Message</h3>
              <form className="space-y-4">
                <input
                  type="text"
                  placeholder="Your Name"
                  className="w-full p-3 rounded border border-gray-300 text-gray-800 placeholder-gray-500"
                />
                <input
                  type="email"
                  placeholder="Your Email"
                  className="w-full p-3 rounded border border-gray-300 text-gray-800 placeholder-gray-500"
                />
                <textarea
                  placeholder="Your Message"
                  rows={4}
                  className="w-full p-3 rounded border border-gray-300 text-gray-800 placeholder-gray-500"
                ></textarea>
                <button className="w-full px-6 py-3 bg-teal-600 text-white rounded hover:bg-teal-700 transition-colors font-medium">
                  Send Message
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};
