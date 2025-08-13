import { User, TrendingUp, FolderOpen, GraduationCap, FileText, type LucideIcon } from 'lucide-react';

export type SectionId = 'about' | 'experience' | 'projects' | 'skills' | 'education' | 'contact' | 'resume';
export type SectionLabel = 'About' | 'Experience' | 'Projects' | 'Skills' | 'Education' | 'Contact' | 'Resume';

export type SectionItem = {
  id: SectionId;
  label: SectionLabel;
  icon: LucideIcon;
};

export const SectionItems: SectionItem[] = [
  { id: 'about', label: 'About', icon: User },
  { id: 'experience', label: 'Experience', icon: TrendingUp },
  { id: 'projects', label: 'Projects', icon: FolderOpen },
  // { id: 'skills', label: 'Skills', icon: Award },
  { id: 'education', label: 'Education', icon: GraduationCap },
  // { id: 'contact', label: 'Contact', icon: Mail },
  { id: 'resume', label: 'Resume', icon: FileText },
];
