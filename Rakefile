desc "push out a tagged release to cocoapods"
task :release, [:version] do |t, args|
  version = args.version

  sh "subl #{podspec} --wait"
  sh "pod spec lint #{podspec} --quick"
  sh %Q|git commit #{podspec} -m "Release #{version}"|
  sh "git tag #{version}"
  sh "git push"
  sh "git push --tags"
  sh "pod push rhgills-private"
end

def podspec
  'RGKit.podspec'
end