require 'spec_helper'

describe 'countries-patch' do
  it "looks up a country's alpha-2 code through its name" do
    expect(Country.find_alpha2('Singapore')).to eq('SG')
    expect(Country.find_alpha2('United States of America')).to eq('US')
    expect(Country.find_alpha2('Australia')).to eq('AU')
    expect(Country.find_alpha2('China')).to eq('CN')
  end

  it "looks up a country's alpha-2 code through its unofficial names" do
    expect(Country.find_alpha2('China P.R.C')).to eq('CN')
    expect(Country.find_alpha2('United States')).to eq('US')
    expect(Country.find_alpha2('Korea (Republic of)')).to eq('KR')
  end

  it "looks up a country's alpha-2 code through gem-defined aliases" do
    expect(Country.find_alpha2('UAE')).to eq('AE')
    expect(Country.find_alpha2('China (excludes SARs and Taiwan)')).to eq('CN')
    expect(Country.find_alpha2('Korea, Republic of (South)')).to eq('KR')
    expect(Country.find_alpha2('Republic of Korea')).to eq('KR')
    expect(Country.find_alpha2('USA')).to eq('US')
  end

  it 'finds a country through its name' do
    expect(Country.try_find('United States of America')).to eq(Country[:US])
    expect(Country.try_find('India')).to eq(Country[:IN])
    expect(Country.try_find('Indonesia')).to eq(Country[:ID])
  end
end
