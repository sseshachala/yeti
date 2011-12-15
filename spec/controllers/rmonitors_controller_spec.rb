require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe RmonitorsController do

  # This should return the minimal set of attributes required to create a valid
  # Rmonitor. As you add validations to Rmonitor, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all rmonitors as @rmonitors" do
      rmonitor = Rmonitor.create! valid_attributes
      get :index
      assigns(:rmonitors).should eq([rmonitor])
    end
  end

  describe "GET show" do
    it "assigns the requested rmonitor as @rmonitor" do
      rmonitor = Rmonitor.create! valid_attributes
      get :show, :id => rmonitor.id
      assigns(:rmonitor).should eq(rmonitor)
    end
  end

  describe "GET new" do
    it "assigns a new rmonitor as @rmonitor" do
      get :new
      assigns(:rmonitor).should be_a_new(Rmonitor)
    end
  end

  describe "GET edit" do
    it "assigns the requested rmonitor as @rmonitor" do
      rmonitor = Rmonitor.create! valid_attributes
      get :edit, :id => rmonitor.id
      assigns(:rmonitor).should eq(rmonitor)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Rmonitor" do
        expect {
          post :create, :rmonitor => valid_attributes
        }.to change(Rmonitor, :count).by(1)
      end

      it "assigns a newly created rmonitor as @rmonitor" do
        post :create, :rmonitor => valid_attributes
        assigns(:rmonitor).should be_a(Rmonitor)
        assigns(:rmonitor).should be_persisted
      end

      it "redirects to the created rmonitor" do
        post :create, :rmonitor => valid_attributes
        response.should redirect_to(Rmonitor.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved rmonitor as @rmonitor" do
        # Trigger the behavior that occurs when invalid params are submitted
        Rmonitor.any_instance.stub(:save).and_return(false)
        post :create, :rmonitor => {}
        assigns(:rmonitor).should be_a_new(Rmonitor)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Rmonitor.any_instance.stub(:save).and_return(false)
        post :create, :rmonitor => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested rmonitor" do
        rmonitor = Rmonitor.create! valid_attributes
        # Assuming there are no other rmonitors in the database, this
        # specifies that the Rmonitor created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Rmonitor.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => rmonitor.id, :rmonitor => {'these' => 'params'}
      end

      it "assigns the requested rmonitor as @rmonitor" do
        rmonitor = Rmonitor.create! valid_attributes
        put :update, :id => rmonitor.id, :rmonitor => valid_attributes
        assigns(:rmonitor).should eq(rmonitor)
      end

      it "redirects to the rmonitor" do
        rmonitor = Rmonitor.create! valid_attributes
        put :update, :id => rmonitor.id, :rmonitor => valid_attributes
        response.should redirect_to(rmonitor)
      end
    end

    describe "with invalid params" do
      it "assigns the rmonitor as @rmonitor" do
        rmonitor = Rmonitor.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Rmonitor.any_instance.stub(:save).and_return(false)
        put :update, :id => rmonitor.id, :rmonitor => {}
        assigns(:rmonitor).should eq(rmonitor)
      end

      it "re-renders the 'edit' template" do
        rmonitor = Rmonitor.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Rmonitor.any_instance.stub(:save).and_return(false)
        put :update, :id => rmonitor.id, :rmonitor => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested rmonitor" do
      rmonitor = Rmonitor.create! valid_attributes
      expect {
        delete :destroy, :id => rmonitor.id
      }.to change(Rmonitor, :count).by(-1)
    end

    it "redirects to the rmonitors list" do
      rmonitor = Rmonitor.create! valid_attributes
      delete :destroy, :id => rmonitor.id
      response.should redirect_to(rmonitors_url)
    end
  end

end
