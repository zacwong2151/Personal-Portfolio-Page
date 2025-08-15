import PeerPrep from '../images/PeerPrep.png';
import PPP from '../images/PPP.png';
import zordle from '../images/zordle.png';

type project = {
  id: number;
  title: string;
  image: string;
  description: string;
  technologies: string[];
  githubUrl: string;
  liveUrl?: string;
};

export const projects: project[] = [
  {
    id: 1,
    title: 'Personal Portfolio Page',
    image: PPP,
    description: 'Hosted and deployed using Amazon services with Terraform as IAC',
    technologies: ['AWS', 'Terraform', 'GitHub Actions'],
    githubUrl: 'https://github.com/zacwong2151/Personal-Portfolio-Page',
    liveUrl: 'https://loonymoony.click/',
  },
  {
    id: 2,
    title: 'Zordle',
    image: zordle,
    description: 'Unlimited Wordle if you are extremely bored, plus a 1v1 option!',
    technologies: ['PostgreSQL', 'ExpressJS', 'React'],
    githubUrl: 'https://github.com/zacwong2151/zordle',
    liveUrl: 'https://zordle.fly.dev/',
  },
  {
    id: 3,
    title: 'PeerPrep',
    image: PeerPrep,
    description: 'Online platform to practise DSA questions with a friend',
    technologies: ['Docker', 'ExpressJS', 'MongoDB', 'React'],
    githubUrl: 'https://github.com/CS3219-AY2425S1/cs3219-ay2425s1-project-g36',
  },
];
