function output = fit_suite_reflection(args)
    [x,y] = meshgrid(args.x, args.y);
    output =args.a.*abs(reflection(x.*1e6.*2.*pi,y-2000,0,1e-21,'L',args.L,'C',args.C));
end