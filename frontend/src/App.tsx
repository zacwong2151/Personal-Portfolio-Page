import { useState, useEffect } from 'react';
import { Sidebar } from './components/Sidebar';
import { About } from './components/About';
import { Experience } from './components/Experience';
import { Projects } from './components/Projects';
import { Education } from './components/Education';
import { Resume } from './components/Resume';
import { SectionItems, type SectionId } from './data/sectionItems';
import * as z from 'zod';

export type VisitorCountLoadingState = 'Loading..' | 'Error loading count' | 'Network error';

const API_RESPONSE = z.object({
  message: z.string(),
  clientIp: z.ipv4(),
  visitorCount: z.int().gte(0),
});

const API_ENDPOINT = 'https://api.loonymoony.click/visitor-count';

export const App = () => {
  const [activeSection, setActiveSection] = useState<SectionId>('about');
  const [visitorCount, setVisitorCount] = useState<VisitorCountLoadingState | number>('Loading..');


  useEffect(() => {
    const fetchVisitorCount = async () => {
      try {
        const response = await fetch(API_ENDPOINT, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          // Send an empty JSON body as POST requests typically expect one, even if your Lambda doesn't explicitly use its content.
          body: JSON.stringify({}),
        });

        if (!response.ok) {
          const errorData = await response.json();
          setVisitorCount('Error loading count');

          console.error('Failed to get/update visitor count:', response.status, errorData);
          return;
        }
    
        const result = API_RESPONSE.safeParse(await response.json())
        if (result.success) {
            setVisitorCount(result.data.visitorCount);
        } else {
            setVisitorCount("Error loading count");

            console.error("Invalid schema returned from Lambda function", result.error)
        }
      } catch (error) {
        setVisitorCount('Network error');
      }
    };
    fetchVisitorCount();
  }, []);

  useEffect(() => {
    const handleScroll = () => {
      const sections: SectionId[] = SectionItems.map((item) => item.id);
      const currentSection: SectionId | undefined = sections.find((section) => {
        const element = document.getElementById(section);
        if (element) {
          const rect = element.getBoundingClientRect();
          return rect.top <= 100 && rect.bottom >= 100;
        }
        return false;
      });

      if (!currentSection) {
        setActiveSection('about'); // default section
      } else if (currentSection && currentSection !== activeSection) {
        setActiveSection(currentSection);
      }
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, [activeSection]);

  return (
    <div className="min-h-screen bg-gradient-to-br from-teal-600 to-teal-800 flex">
      <Sidebar activeSection={activeSection} />
      <div className="flex-1 md:ml-64">
        <About visitorCount={visitorCount} />
        <Experience />
        <Projects />
        <Education />
        {/* <Skills /> */}
        <Resume />
        {/* <Contact /> */}
      </div>
    </div>
  );
};
