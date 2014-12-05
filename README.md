TrinityVM
=========
VM for Trinity workshops etc.

URL: https://zih-a35.github.io/trinityvm/index.html

Releases with DOI
=================
* Version 0.1 [![DOI](https://zenodo.org/badge/7452/zih-a35/trinityvm.svg)](http://dx.doi.org/10.5281/zenodo.12977)

getting up to speed with github pages
=====================================
* check your ruby version `ruby --version`
* install bundler `gem install bundler`
* install jekyll and all needed dependencies `bundle install`
 * the magic is in the `Gemfile`, for details look there
* to run jenkyll locally, `bundle exec jekyll serve`
* github only looks at the gh-pages branch for updates to your website, just use the script `update-pages` to rebase everything to the gh-pages branch

Packer
======
* What is packer
* How does it work

Howto install packer
--------------------
* install [Packer](http://www.packer.io/docs/installation.html)
* install [VirtualBox](http://wiki.ubuntuusers.de/VirtualBox/Installation)
* install [VirtualBox Plugin](https://help.ubuntu.com/community/VirtualBox/GuestAdditions)
* Validate .JSON File`packer validate ubuntu_64.json`
* Build Packer `packer build ubuntu_64.json`

Howto Build an ubuntu vm
========================
The preceed file steers the ubuntu install process. The kernel grabs 
the file of an URL. This is why we use github pages so that we have a 
static url to point to in the packer configuration.

Preceed file
============
The preceed file for packer can be found [here]({{ site.baseurl }}/download/preseed.cfg).

Evaluate Trinity assemblies
===========================

The data sets are available from the Trinity ftp site:

 http://sourceforge.net/projects/trinityrnaseq/files/misc/

with reads under the schizo, drosophila, or mouse subdirectories.

The schizo and mouse data are strand-specific (so can run Trinity with option `--SS_lib_type RF`), whereas the drosophila data is not strand-specific (no additional options).

Each subdirectory also contains a corresponding set of transcript sequences used for evaluating full-length reconstruction.

Given a Trinity assembly ('Trinity.fasta') derived from assembly of the above read sets, the following script is used to examine the number of fully reconstructed reference transcripts:

`$TRINITY_HOME/Analysis/FL_reconstruction_analysis/FL_trans_analysis_pipeline.pl`

{% highlight bash %}
#########################################################################################################################
#
# 
#  --target <string>    transcript fasta file (headers must have accessions that look like so:   transcript_id;gene_id
#  --query <string>     Trinity.fa
#  
#  --min_per_id <int>   min percent identity (default: 99)
#  --max_per_gap <int>  max percent gaps  (default: 1)
#
#  --forward_orient     strand-specific assemblies, only consider the forward strand.
#
#  --include_tiers      write the top tiers file
#
#  --allow_non_unique_mappings    a single query transcript counts towards all transcripts encapsulated  
#
#########################################################################################################################
{% endhighlight %}

Run this with parameters `--target  refTranscripts.fa  --query Trinity.fasta`

If the assembly is performed using the strand-specific options, then also include: `--forward_orient`

That's pretty much it.  Run it on an 'original' Trinity assembly, and run it on your assembly generated using a modified version of Trinity.

The script generates 4 numbers, tab-delimited:

1.  total genes full-length (at least one isoform is fully reconstructed)
2.  total isoforms reconstructed to full-length
3.  number of full-length genes found 'fused' (single trinity transcript including multiple full-length transcripts)
4.  number of full-length isoforms found within 'fused' transcripts.

In addition to the above, I simply count the total number of transcripts assembled:

{% highlight bash %}
grep '>' Trinity.fasta | wc -l
{% endhighlight %}

That's it



