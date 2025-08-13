import { type SectionId } from "../data/sectionItems";

export const scrollToSection = (sectionId: SectionId) => {
  const element = document.getElementById(sectionId);
  if (element) {
    element.scrollIntoView({ behavior: 'smooth' });
  }
};
