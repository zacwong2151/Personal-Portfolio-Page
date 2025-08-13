import koala from '../images/koala.jpg';
import { SectionItems } from '../data/sectionItems';
import { scrollToSection } from '../utils/util';
import type { SectionId } from '../data/sectionItems';

export const Sidebar = ({
  activeSection,
}: {
  activeSection: SectionId;
}) => {
  return (
    <div className="w-64 bg-white shadow-lg flex flex-col fixed h-full z-10">
      <div>
        <img src={koala} alt="Logo" />
      </div>

      <nav className="flex-1 py-4 overflow-y-auto">
        {SectionItems.map((item) => {
          const Icon = item.icon;
          return (
            <button
              key={item.id}
              onClick={() => scrollToSection(item.id)}
              className={`w-full flex items-center gap-3 px-6 py-3 text-left hover:bg-teal-50 transition-colors ${
                activeSection === item.id ? 'bg-teal-50 border-r-4 border-teal-600 text-teal-700' : 'text-gray-600'
              }`}
            >
              <Icon className="w-5 h-5" />
              <span className="font-medium">{item.label}</span>
            </button>
          );
        })}
      </nav>
    </div>
  );
};
