require 'spec_helper'

describe Projects::New do
  let(:project) { double('project') }
  let(:presenter) { double('presenter') }
  let(:template) { double('template') }
  subject(:view) { Projects::New.new(template, {project: project}) }

  before do
    allow(ProjectPresenter).to receive(:new).with(project).and_return(presenter)
  end

  describe '#project' do
    it 'should return presenter' do
      expect(ProjectPresenter).to receive(:new).with(project).and_return(presenter)
      expect(view.project).to eql(presenter)
    end
  end

  describe '#form' do
    let(:form) { double('form') }

    it 'should return form' do
      expect(Forme::Form).to receive(:new).with(presenter).and_return(form)
      expect(view.form).to eql(form)
    end
  end
end