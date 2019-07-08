double safe_sqrt(double x)
{
#ifdef DEBUG
  if (x<0.)
    std::cerr << "Problem in sqrt\n";
#endif
  return std::sqrt(x);
}
