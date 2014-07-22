require 'spec_helper'
# Compare results of rendering pages via rails and via the old php app

describe MembersController do
  include HTMLCompareHelper
  fixtures :all

  it "#index" do
    compare("/mps.php")
    compare("/mps.php?sort=lastname")
    compare("/mps.php?sort=constituency")
    compare("/mps.php?sort=party")
    compare("/mps.php?sort=rebellions")
    compare("/mps.php?sort=attendance")

    compare("/mps.php?house=senate")
    compare("/mps.php?house=senate&sort=lastname")
    compare("/mps.php?house=senate&sort=constituency")
    compare("/mps.php?house=senate&sort=party")
    compare("/mps.php?house=senate&sort=rebellions")
    compare("/mps.php?house=senate&sort=attendance")

    compare("/mps.php?house=all")
    compare("/mps.php?house=all&sort=lastname")
    compare("/mps.php?house=all&sort=constituency")
    compare("/mps.php?house=all&sort=party")
    compare("/mps.php?house=all&sort=rebellions")
    compare("/mps.php?house=all&sort=attendance")

    compare("/mps.php?parliament=all")
    compare("/mps.php?parliament=all&sort=lastname")
    compare("/mps.php?parliament=all&sort=constituency")
    compare("/mps.php?parliament=all&sort=party")
    compare("/mps.php?parliament=all&sort=rebellions")
    compare("/mps.php?parliament=all&sort=attendance")
    compare("/mps.php?parliament=all&house=senate")
    compare("/mps.php?parliament=all&house=senate&sort=lastname")
    compare("/mps.php?parliament=all&house=senate&sort=constituency")
    compare("/mps.php?parliament=all&house=senate&sort=party")
    compare("/mps.php?parliament=all&house=senate&sort=rebellions")
    compare("/mps.php?parliament=all&house=senate&sort=attendance")
    compare("/mps.php?parliament=all&house=all")
    compare("/mps.php?parliament=all&house=all&sort=lastname")
    compare("/mps.php?parliament=all&house=all&sort=constituency")
    compare("/mps.php?parliament=all&house=all&sort=party")
    compare("/mps.php?parliament=all&house=all&sort=rebellions")
    compare("/mps.php?parliament=all&house=all&sort=attendance")

    compare("/mps.php?parliament=2013")
    compare("/mps.php?parliament=2013&sort=lastname")
    compare("/mps.php?parliament=2013&sort=constituency")
    compare("/mps.php?parliament=2013&sort=party")
    compare("/mps.php?parliament=2013&sort=rebellions")
    compare("/mps.php?parliament=2013&sort=attendance")
    compare("/mps.php?parliament=2013&house=senate")
    compare("/mps.php?parliament=2013&house=senate&sort=lastname")
    compare("/mps.php?parliament=2013&house=senate&sort=constituency")
    compare("/mps.php?parliament=2013&house=senate&sort=party")
    compare("/mps.php?parliament=2013&house=senate&sort=rebellions")
    compare("/mps.php?parliament=2013&house=senate&sort=attendance")
    compare("/mps.php?parliament=2013&house=all")
    compare("/mps.php?parliament=2013&house=all&sort=lastname")
    compare("/mps.php?parliament=2013&house=all&sort=constituency")
    compare("/mps.php?parliament=2013&house=all&sort=party")
    compare("/mps.php?parliament=2013&house=all&sort=rebellions")
    compare("/mps.php?parliament=2013&house=all&sort=attendance")

    compare("/mps.php?parliament=2010")
    compare("/mps.php?parliament=2010&sort=lastname")
    compare("/mps.php?parliament=2010&sort=constituency")
    compare("/mps.php?parliament=2010&sort=party")
    compare("/mps.php?parliament=2010&sort=rebellions")
    compare("/mps.php?parliament=2010&sort=attendance")
    compare("/mps.php?parliament=2010&house=senate")
    compare("/mps.php?parliament=2010&house=senate&sort=lastname")
    compare("/mps.php?parliament=2010&house=senate&sort=constituency")
    compare("/mps.php?parliament=2010&house=senate&sort=party")
    compare("/mps.php?parliament=2010&house=senate&sort=rebellions")
    compare("/mps.php?parliament=2010&house=senate&sort=attendance")
    compare("/mps.php?parliament=2010&house=all")
    compare("/mps.php?parliament=2010&house=all&sort=lastname")
    compare("/mps.php?parliament=2010&house=all&sort=constituency")
    compare("/mps.php?parliament=2010&house=all&sort=party")
    compare("/mps.php?parliament=2010&house=all&sort=rebellions")
    compare("/mps.php?parliament=2010&house=all&sort=attendance")

    compare("/mps.php?parliament=2007")
    compare("/mps.php?parliament=2007&sort=lastname")
    compare("/mps.php?parliament=2007&sort=constituency")
    compare("/mps.php?parliament=2007&sort=party")
    compare("/mps.php?parliament=2007&sort=rebellions")
    compare("/mps.php?parliament=2007&sort=attendance")
    compare("/mps.php?parliament=2007&house=senate")
    compare("/mps.php?parliament=2007&house=senate&sort=lastname")
    compare("/mps.php?parliament=2007&house=senate&sort=constituency")
    compare("/mps.php?parliament=2007&house=senate&sort=party")
    compare("/mps.php?parliament=2007&house=senate&sort=rebellions")
    compare("/mps.php?parliament=2007&house=senate&sort=attendance")
    compare("/mps.php?parliament=2007&house=all")
    compare("/mps.php?parliament=2007&house=all&sort=lastname")
    compare("/mps.php?parliament=2007&house=all&sort=constituency")
    compare("/mps.php?parliament=2007&house=all&sort=party")
    compare("/mps.php?parliament=2007&house=all&sort=rebellions")
    compare("/mps.php?parliament=2007&house=all&sort=attendance")

    compare("/mps.php?parliament=2004")
    compare("/mps.php?parliament=2004&sort=lastname")
    compare("/mps.php?parliament=2004&sort=constituency")
    compare("/mps.php?parliament=2004&sort=party")
    compare("/mps.php?parliament=2004&sort=rebellions")
    compare("/mps.php?parliament=2004&sort=attendance")
    compare("/mps.php?parliament=2004&house=senate")
    compare("/mps.php?parliament=2004&house=senate&sort=lastname")
    compare("/mps.php?parliament=2004&house=senate&sort=constituency")
    compare("/mps.php?parliament=2004&house=senate&sort=party")
    compare("/mps.php?parliament=2004&house=senate&sort=rebellions")
    compare("/mps.php?parliament=2004&house=senate&sort=attendance")
    compare("/mps.php?parliament=2004&house=all")
    compare("/mps.php?parliament=2004&house=all&sort=lastname")
    compare("/mps.php?parliament=2004&house=all&sort=constituency")
    compare("/mps.php?parliament=2004&house=all&sort=party")
    compare("/mps.php?parliament=2004&house=all&sort=rebellions")
    compare("/mps.php?parliament=2004&house=all&sort=attendance")
  end

  it "#show" do
    compare("/mp.php?mpn=Tony_Abbott&mpc=Warringah&house=representatives")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives")
    compare("/mp.php?mpn=Christine_Milne&mpc=Senate&house=senate")

    compare("/mp.php?mpn=Tony_Abbott&mpc=Warringah&house=representatives&display=allvotes")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&display=allvotes")
    compare("/mp.php?mpn=Christine_Milne&mpc=Senate&house=senate&display=allvotes")

    compare("/mp.php?mpn=Tony_Abbott&mpc=Warringah&house=representatives&display=everyvote")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&display=everyvote")
    compare("/mp.php?mpn=Christine_Milne&mpc=Senate&house=senate&display=everyvote")

    compare("/mp.php?mpn=Tony_Abbott&mpc=Warringah&house=representatives&display=allfriends")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&display=allfriends")
    compare("/mp.php?mpn=Christine_Milne&mpc=Senate&house=senate&display=allfriends")

    compare("/mp.php?mpn=Tony_Abbott&mpc=Warringah&house=representatives&display=alldreams")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&display=alldreams")
    compare("/mp.php?mpn=Christine_Milne&mpc=Senate&house=senate&display=alldreams")

    compare("/mp.php?mpn=Tony_Abbott&mpc=Warringah&house=representatives&dmp=1")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&dmp=1")
    compare("/mp.php?mpn=Christine_Milne&mpc=Senate&house=senate&dmp=1")

    compare("/mp.php?mpn=Tony_Abbott&mpc=Warringah&house=representatives&dmp=1&display=motions")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&dmp=1&display=motions")
    compare("/mp.php?mpn=Christine_Milne&mpc=Senate&house=senate&dmp=1&display=motions")

    # vote comparison pages
    # 100% agreement
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&mpn2=Tony_Abbott&mpc2=Warringah&house2=representatives")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&mpn2=Tony_Abbott&mpc2=Warringah&house2=representatives&display=difference")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&mpn2=Tony_Abbott&mpc2=Warringah&house2=representatives&display=allvotes")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&mpn2=Tony_Abbott&mpc2=Warringah&house2=representatives&display=everyvote")
    # 0%<agreement<100%
    compare("/mp.php?mpn=Christopher_Back&mpc=Senate&house=senate&mpn2=Christine_Milne&mpc2=Senate&house2=senate")
    compare("/mp.php?mpn=Christopher_Back&mpc=Senate&house=senate&mpn2=Christine_Milne&mpc2=Senate&house2=senate&display=difference")
    compare("/mp.php?mpn=Christopher_Back&mpc=Senate&house=senate&mpn2=Christine_Milne&mpc2=Senate&house2=senate&display=allvotes")
    compare("/mp.php?mpn=Christopher_Back&mpc=Senate&house=senate&mpn2=Christine_Milne&mpc2=Senate&house2=senate&display=everyvote")
    # 0% agreement (temporarily disabled until https://github.com/openaustralia/publicwhip/issues/150 is fixed)
    #compare("/mp.php?mpn=Disagreeable_Curmudgeon&mpc=Senate&house=senate&mpn2=Surly_Nihilist&mpc2=Senate&house2=senate")
    #compare("/mp.php?mpn=Disagreeable_Curmudgeon&mpc=Senate&house=senate&mpn2=Surly_Nihilist&mpc2=Senate&house2=senate&display=difference")
    #compare("/mp.php?mpn=Disagreeable_Curmudgeon&mpc=Senate&house=senate&mpn2=Surly_Nihilist&mpc2=Senate&house2=senate&display=allvotes")
    #compare("/mp.php?mpn=Disagreeable_Curmudgeon&mpc=Senate&house=senate&mpn2=Surly_Nihilist&mpc2=Senate&house2=senate&display=everyvote")
    # when one mp has no votes whatsoever
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&mpn2=Paul_Zammit&mpc2=Lowe&house2=representatives")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&mpn2=Paul_Zammit&mpc2=Lowe&house2=representatives&display=difference")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&mpn2=Paul_Zammit&mpc2=Lowe&house2=representatives&display=allvotes")
    compare("/mp.php?mpn=Kevin_Rudd&mpc=Griffith&house=representatives&mpn2=Paul_Zammit&mpc2=Lowe&house2=representatives&display=everyvote")

    compare("/mp.php?mpc=Warringah")
    compare("/mp.php?mpc=Bennelong")

    compare("/mp.php?mpid=1&dmp=1")
    compare("/mp.php?id=uk.org.publicwhip/member/1")
    compare("/mp.php?id=uk.org.publicwhip/member/1&showall=yes")
  end
end
