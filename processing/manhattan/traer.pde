import java.util.Iterator;

// Traer Physics 3.0
// Terms from Traer's download page, http://traer.cc/mainsite/physics/
//   LICENSE - Use this code for whatever you want, just send me a link jeff@traer.cc
//
// traer3a_01.pde 
//   From traer.physics - author: Jeff Traer
//     Attraction              Particle                     
//     EulerIntegrator         ParticleSystem  
//     Force                   RungeKuttaIntegrator         
//     Integrator              Spring
//     ModifiedEulerIntegrator Vector3D          
//
//   From traer.animator - author: Jeff Traer   
//     Smoother                                       
//     Smoother3D                  
//     Tickable     
//
//   New code - author: Carl Pearson
//     UniversalAttraction
//     Pulse
//

// 13 Dec 2010: Copied 3.0 src from http://traer.cc/mainsite/physics/ and ported to Processingjs,
//              added makeParticle2(), makeAttraction2(), replaceAttraction(), and removeParticle(int) -mrn (Mike Niemi)
//  9 Feb 2011: Fixed bug in Euler integrators where they divided by time instead of 
//              multiplying by it in the update steps,
//              eliminated the Vector3D class (converting the code to use the native PVector class),
//              did some code compaction in the RK solver,
//              added a couple convenience classes, UniversalAttraction and Pulse, simplifying 
//              the Pendulums sample (renamed to dynamics.pde) considerably. -cap (Carl Pearson)
// 24 Mar 2011: Changed the switch statement in ParticleSystem.setIntegrator() to an if-then-else
//              to avoid an apparent bug introduced in Processing-1.1.0.js where the 
//              variable, RUNGE_KUTTA, was not visible inside the switch statement.
//              Changed ModifiedEulerIntegrator to use the documented PVector interfaces to work with pjs. -mrn
//  8 Jan 2013: Added "import java.util.Iterator" so it will now work in the Processing 2.0 IDE,
//              just flip the mode buttion in the upper right corner of the IDE between "JAVA" to "JAVASCRIPT".

//===========================================================================================
//                                      Attraction
//===========================================================================================
// attract positive repel negative
//package traer.physics;
public class Attraction implements Force {
  final Particle one;
  final Particle b;
  final float k;
  final float distanceMin;
  final float distanceMinSquared;
  boolean on = true;

  public Attraction( Particle a, Particle b, float k, float distanceMin ) {
    this.one = a;
    this.b = b;
    this.k = k;
    this.distanceMin = distanceMin;
    this.distanceMinSquared = distanceMin*distanceMin;
  }

  public final float    getMinimumDistance() { 
    return distanceMin;
  }
  public final void     turnOff() { 
    on = false;
  }
  public final void     turnOn() { 
    on = true;
  }


  public void apply() { 
    if ( on && ( one.isFree() || b.isFree() ) ) {
      PVector a2b = PVector.sub(one.position, b.position, new PVector());
      float a2bDistanceSquared = a2b.dot(a2b);

      if ( a2bDistanceSquared < distanceMinSquared )
        a2bDistanceSquared = distanceMinSquared;

      float force = k * one.mass * b.mass / (a2bDistanceSquared * (float)Math.sqrt(a2bDistanceSquared));

      a2b.mult( force );

      // apply
      if ( b.isFree() )
        b.force.add( a2b );  
      if ( one.isFree() ) {
        a2b.mult(-1f);
        one.force.add( a2b );
      }
    }
  }

  public final float   getStrength() { 
    return k;
  }
  public final boolean isOn() { 
    return on;
  }
} // Attraction

//===========================================================================================
//                                    UniversalAttraction
//===========================================================================================
// attract positive repel negative
public class UniversalAttraction implements Force {
  final float k;
  final float distanceMin;
  final ArrayList<Particle> targetList;
  final float distanceMinSquared;
  boolean on = true;

  public UniversalAttraction( float k, float distanceMin, ArrayList<Particle> targetList ) {
    this.k = k;
    this.distanceMin = distanceMin;
    this.distanceMinSquared = distanceMin*distanceMin;
    this.targetList = targetList;
  }

  public final float    getMinimumDistance() { 
    return distanceMin;
  }
  public final void     turnOff() { 
    on = false;
  }
  public final void     turnOn() { 
    on = true;
  }
  public final float   getStrength() { 
    return k;
  }
  public final boolean isOn() { 
    return on;
  }

  public void apply() { 
    if ( on ) {
      for (int i=0; i < targetList.size (); i++ ) {
        for (int j=i+1; j < targetList.size (); j++) {
          Particle a = targetList.get(i);
          Particle b = targetList.get(j);
          if ( a.isFree() || b.isFree() ) {
            PVector a2b = PVector.sub(a.position, b.position, new PVector());
            float a2bDistanceSquared = a2b.dot(a2b);
            if ( a2bDistanceSquared < distanceMinSquared ) {
              a2bDistanceSquared = distanceMinSquared;
            }  
            float force = k * a.mass * b.mass / (a2bDistanceSquared * (float)Math.sqrt(a2bDistanceSquared));
            a2b.mult( force );

            if ( b.isFree() ) {
              b.force.add( a2b );
            } 
            if ( a.isFree() ) {
              a2b.mult(-1f);
              a.force.add( a2b );
            }
          }
        }
      }
    }
  }
} //UniversalAttraction

//===========================================================================================
//                                    Pulse
//===========================================================================================
public class Pulse implements Force {
  final float k;
  final float distanceMin;
  final float distanceMinSquared;
  final PVector origin;
  final ArrayList<Particle> targetList;
  float lifetime;
  boolean on = true;

  public Pulse( float k, float distanceMin, PVector origin, float lifetime, ArrayList<Particle> targetList ) {
    this.k = k;
    this.distanceMin = distanceMin;
    this.distanceMinSquared = distanceMin*distanceMin;
    this.origin = origin;
    this.targetList = targetList;
    this.lifetime = lifetime;
  }


  public final void     turnOff() { 
    on = false;
  }
  public final void     turnOn() { 
    on = true;
  }
  public final boolean  isOn() { 
    return on;
  }
  public final boolean  tick( float time ) { 
    lifetime-=time; 
    if (lifetime <= 0f) turnOff(); 
    return on;
  }

  public void apply() {
    if (on) {
      PVector holder = new PVector();
      for (Particle p : targetList) {
        if ( p.isFree() ) {
          holder.set( p.position.x, p.position.y, p.position.z );
          holder.sub( origin );
          float distanceSquared = holder.dot(holder);
          if (distanceSquared < distanceMinSquared) distanceSquared = distanceMinSquared;
          holder.mult(k / (distanceSquared * (float)Math.sqrt(distanceSquared)) );
          p.force.add( holder );
        }
      }
    }
  }
}//Pulse

//===========================================================================================
//                                      EulerIntegrator
//===========================================================================================
//package traer.physics;
public class EulerIntegrator implements Integrator {
  final ParticleSystem s;

  public EulerIntegrator( ParticleSystem s ) { 
    this.s = s;
  }
  public void step( float t ) {
    s.clearForces();
    s.applyForces();

    for ( Particle  p : s.particles) {
      if ( p.isFree() ) {
        p.velocity.add( PVector.mult(p.force, t/p.mass) );
        p.position.add( PVector.mult(p.velocity, t) );
      }
    }
  }
} // EulerIntegrator

//===========================================================================================
//                                          Force
//===========================================================================================
// May 29, 2005
//package traer.physics;
// @author jeffrey traer bernstein
public interface Force {
  void    turnOn();
  void    turnOff();
  boolean isOn();
  void    apply();
}

//===========================================================================================
//                                      Integrator
//===========================================================================================
//package traer.physics;
public interface Integrator {
  void step( float t );
}

//===========================================================================================
//                                    ModifiedEulerIntegrator
//===========================================================================================
//package traer.physics;
public class ModifiedEulerIntegrator implements Integrator {
  final ParticleSystem s;
  public ModifiedEulerIntegrator( ParticleSystem s ) { 
    this.s = s;
  }
  public void step( float t ) {
    s.clearForces();
    s.applyForces();

    float halft = 0.5f*t;
    //    float halftt = 0.5f*t*t;
    PVector a = new PVector();
    PVector holder = new PVector();

    for ( int i = 0; i < s.numberOfParticles (); i++ ) {
      Particle p = s.getParticle( i );
      if ( p.isFree() ) { 
        // The following "was"s was the code in traer3a which appears to work in the IDE but not pjs
        // I couln't find the interface Carl used in the PVector documentation and have converted
        // the code to the documented interface. -mrn

        // was in traer3a: PVector.div(p.force, p.mass0, a);
        a.set(p.force.x, p.force.y, p.force.z);
        a.div(p.mass);

        //was in traer3a: p.position.add( PVector.mult(p.velocity, t, holder) );
        holder.set(p.velocity.x, p.velocity.y, p.velocity.z);
        holder.mult(t);
        p.position.add(holder);

        //was in traer3a: p.position.add( PVector.mult(a, halft, a) );
        holder.set(a.x, a.y, a.z);
        holder.mult(halft); // Note that the original Traer code used halftt ( 0.5*t*t ) here -mrn
        p.position.add(holder);

        //was in traer3a: p.velocity.add( PVector.mult(a, t, a) );
        holder.set(a.x, a.y, a.z);
        holder.mult(t);
        p.velocity.add(a);
      }
    }
  }
} // ModifiedEulerIntegrator

//===========================================================================================
//                                         Particle
//===========================================================================================
//package traer.physics;
public class Particle {
  final float    mass;
  final PVector position = new PVector();
  final PVector velocity = new PVector();
  final PVector force = new PVector();
  protected float    age = 0;
  protected boolean  dead = false;
  boolean            fixed = false;

  public Particle( float mass ) { 
    this.mass = mass;
  }

  // @see traer.physics.AbstractParticle#distanceTo(traer.physics.Particle)
  public final float distanceTo( Particle p ) { 
    return this.position.dist( p.position );
  }

  // @see traer.physics.AbstractParticle#makeFixed()
  public final Particle makeFixed() {
    fixed = true;
    velocity.set(0f, 0f, 0f);
    force.set(0f, 0f, 0f);
    return this;
  }

  // @see traer.physics.AbstractParticle#makeFree()
  public final Particle makeFree() {
    fixed = false;
    return this;
  }


  // @see traer.physics.AbstractParticle#isFree()
  public final boolean isFree() { 
    return !fixed;
  }
} // Particle

//===========================================================================================
//                                      ParticleSystem
//===========================================================================================
// May 29, 2005
//package traer.physics;
//import java.util.*;
public class ParticleSystem {
  public static final int RUNGE_KUTTA = 0;
  public static final int MODIFIED_EULER = 1;
  protected static final float DEFAULT_GRAVITY = 0;
  protected static final float DEFAULT_DRAG = 0.001f;  
  final ArrayList<Particle>  particles = new ArrayList<Particle>();
  final ArrayList<Spring>  springs = new ArrayList<Spring>();
  final ArrayList<Attraction>  attractions = new ArrayList();
  final ArrayList<Force>  customForces = new ArrayList();
  final ArrayList<Pulse>  pulses = new ArrayList<Pulse>();
  Integrator integrator;
  PVector    gravity = new PVector();
  float      drag;
  boolean    hasDeadParticles = false;

  public final void setIntegrator( int which ) {
    if ( which==RUNGE_KUTTA ) {
      this.integrator = new RungeKuttaIntegrator( this );
    } else {
      if ( which==MODIFIED_EULER ) {
        this.integrator = new ModifiedEulerIntegrator( this );
      }
    }
  }

  public final void setGravity( float x, float y, float z ) { 
    gravity.set( x, y, z );
  }

  // default down gravity
  public final void     setGravity( float g ) { 
    gravity.set( 0, g, 0 );
  }
  public final void     setDrag( float d ) { 
    drag = d;
  }
  public final void     tick() { 
    tick( 1 );
  }
  public final void     tick( float t ) {
    integrator.step( t );
    for (int i = 0; i<pulses.size (); ) {
      Pulse p = pulses.get(i);
      p.tick(t);
      if (p.isOn()) { 
        i++;
      } else { 
        pulses.remove(i);
      }
    }
    for (Iterator i = pulses.iterator (); i.hasNext(); ) {
      Pulse p = (Pulse)(i.next());
      p.tick( t );
      if (!p.isOn()) i.remove();
    }
  }

  public final Particle makeParticle( float mass, float x, float y, float z ) {
    Particle p = new Particle( mass );
    p.position.set( x, y, z );
    particles.add( p );
    return p;
  }


  public final Particle makeParticle() { 
    return makeParticle( 1.0f, 0f, 0f, 0f );
  }

  public final Spring   makeSpring( Particle a, Particle b, float ks, float d, float r ) {
    Spring s = new Spring( a, b, ks, d, r );
    springs.add( s );
    return s;
  }

  public final Attraction makeAttraction( Particle first, Particle b, float k, float minDistance ) {
    Attraction m = new Attraction( first, b, k, minDistance );
    attractions.add( m );
    return m;
  }

  public final void replaceAttraction( int i, Attraction m ) { // mrn
    attractions.set( i, m );
  }  

  public final void addPulse(Pulse pu) { 
    pulses.add(pu);
  }

  public final void clear() {
    particles.clear();
    springs.clear();
    attractions.clear();
    customForces.clear();
    pulses.clear();
  }

  public ParticleSystem( float g, float somedrag ) {
    setGravity( 0f, g, 0f );
    drag = somedrag;
    integrator = new RungeKuttaIntegrator( this );
  }

  public ParticleSystem( float gx, float gy, float gz, float somedrag ) {
    setGravity( gx, gy, gz );
    drag = somedrag;
    integrator = new RungeKuttaIntegrator( this );
  }

  public ParticleSystem() {
    setGravity( 0f, ParticleSystem.DEFAULT_GRAVITY, 0f );
    drag = ParticleSystem.DEFAULT_DRAG;
    integrator = new RungeKuttaIntegrator( this );
  }

  protected final void applyForces() {
    if ( gravity.mag() != 0f ) {
      for ( Iterator i = particles.iterator (); i.hasNext(); ) {
        Particle p = (Particle)i.next();
        if (p.isFree()) p.force.add( gravity );
      }
    }

    PVector target = new PVector();
    for ( Iterator i = particles.iterator (); i.hasNext(); ) {
      Particle p = (Particle)i.next();
      if (p.isFree()) p.force.add( PVector.mult(p.velocity, -drag, target) );
    }

    applyAll(springs);
    applyAll(attractions);
    applyAll(customForces);
    applyAll(pulses);
  }

  private void applyAll(ArrayList<? extends Force> forces) {
    for ( Force force : forces) {
      force.apply();
    }
  }

  protected final void clearForces() {
    for (Particle particle : particles) {
      particle.force.set(0f, 0f, 0f);
    }
  }

  public final int numberOfParticles() { 
    return particles.size();
  }
  public final int numberOfSprings() { 
    return springs.size();
  }
  public final int numberOfAttractions() { 
    return attractions.size();
  }
  public final Particle getParticle( int i ) { 
    return particles.get( i );
  }
  public final Spring getSpring( int i ) { 
    return springs.get( i );
  }
  public final Attraction getAttraction( int i ) { 
    return attractions.get( i );
  }
  public final void addCustomForce( Force f ) { 
    customForces.add( f );
  }
  public final int numberOfCustomForces() { 
    return customForces.size();
  }
  public final Force getCustomForce( int i ) { 
    return customForces.get( i );
  }
  public final Force removeCustomForce( int i ) { 
    return customForces.remove( i );
  }
  public final void removeParticle( int i ) { 
    particles.remove( i );
  } //mrn
  public final void removeParticle( Particle p ) { 
    particles.remove( p );
  }
  public final Spring removeSpring( int i ) { 
    return springs.remove( i );
  }
  public final Attraction removeAttraction( int i ) { 
    return attractions.remove( i );
  }
  public final void removeAttraction( Attraction s ) { 
    attractions.remove( s );
  }
  public final void removeSpring( Spring a ) { 
    springs.remove( a );
  }
  public final void removeCustomForce( Force f ) { 
    customForces.remove( f );
  }
} // ParticleSystem

//===========================================================================================
//                                      RungeKuttaIntegrator
//===========================================================================================
//package traer.physics;
//import java.util.*;
public class RungeKuttaIntegrator implements Integrator
{  
  final ArrayList<PVector> originalPositions = new ArrayList();
  final ArrayList<PVector> originalVelocities = new ArrayList();
  final ArrayList<PVector> k1Forces = new ArrayList();
  final ArrayList<PVector> k1Velocities = new ArrayList();
  final ArrayList<PVector> k2Forces = new ArrayList();
  final ArrayList<PVector> k2Velocities = new ArrayList();
  final ArrayList<PVector> k3Forces = new ArrayList();
  final ArrayList<PVector> k3Velocities = new ArrayList();
  final ArrayList<PVector> k4Forces = new ArrayList();
  final ArrayList<PVector> k4Velocities = new ArrayList();
  final ParticleSystem s;

  public RungeKuttaIntegrator( ParticleSystem s ) { 
    this.s = s;
  }

  final void allocateParticles() {
    while ( s.particles.size () > originalPositions.size() ) {
      originalPositions.add( new PVector() );
      originalVelocities.add( new PVector() );
      k1Forces.add( new PVector() );
      k1Velocities.add( new PVector() );
      k2Forces.add( new PVector() );
      k2Velocities.add( new PVector() );
      k3Forces.add( new PVector() );
      k3Velocities.add( new PVector() );
      k4Forces.add( new PVector() );
      k4Velocities.add( new PVector() );
    }
  }

  private final void setIntermediate(ArrayList<PVector> forces, ArrayList<PVector> velocities) {
    s.applyForces();
    for ( int i = 0; i < s.particles.size (); ++i ) {
      Particle p = (Particle)s.particles.get( i );
      if ( p.isFree() ) {
        forces.get(i).set( p.force.x, p.force.y, p.force.z );
        velocities.get(i).set( p.velocity.x, p.velocity.y, p.velocity.z );
        p.force.set(0f, 0f, 0f);
      }
    }
  }

  private final void updateIntermediate(ArrayList<PVector> forces, ArrayList<PVector> velocities, float multiplier) {
    PVector holder = new PVector();

    for ( int i = 0; i < s.particles.size (); ++i ) {
      Particle p = s.particles.get(i);
      if ( p.isFree() ) {
        PVector op = originalPositions.get(i);
        p.position.set(op.x, op.y, op.z);
        p.position.add(PVector.mult(velocities.get(i), multiplier, holder));    
        PVector ov = originalVelocities.get(i);
        p.velocity.set(ov.x, ov.y, ov.z);
        p.velocity.add(PVector.mult(forces.get(i), multiplier/p.mass, holder));
      }
    }
  }

  private final void initialize() {
    for ( int i = 0; i < s.particles.size (); ++i ) {
      Particle p = s.particles.get(i);
      if ( p.isFree() ) {    
        originalPositions.get(i).set( p.position.x, p.position.y, p.position.z );
        originalVelocities.get(i).set( p.velocity.x, p.velocity.y, p.velocity.z );
      }
      p.force.set(0f, 0f, 0f);  // and clear the forces
    }
  }

  public final void step( float deltaT ) {  
    allocateParticles();
    initialize();       
    setIntermediate(k1Forces, k1Velocities);
    updateIntermediate(k1Forces, k1Velocities, 0.5f*deltaT );
    setIntermediate(k2Forces, k2Velocities);
    updateIntermediate(k2Forces, k2Velocities, 0.5f*deltaT );
    setIntermediate(k3Forces, k3Velocities);
    updateIntermediate(k3Forces, k3Velocities, deltaT );
    setIntermediate(k4Forces, k4Velocities);

    /////////////////////////////////////////////////////////////
    // put them all together and what do you get?
    for ( int i = 0; i < s.particles.size (); ++i ) {
      Particle p = (Particle)s.particles.get( i );
      p.age += deltaT;
      if ( p.isFree() ) {
        // update position
        PVector holder = k2Velocities.get(i);
        holder.add(k3Velocities.get(i));
        holder.mult(2.0f);
        holder.add(k1Velocities.get(i));
        holder.add(k4Velocities.get(i));
        holder.mult(deltaT / 6.0f);
        holder.add(originalPositions.get(i));
        p.position.set(holder.x, holder.y, holder.z);

        // update velocity
        holder = k2Forces.get( i );
        holder.add(k3Forces.get( i ));
        holder.mult(2.0f);
        holder.add(k1Forces.get( i ));
        holder.add(k4Forces.get( i ));
        holder.mult(deltaT / (6.0f * p.mass ));
        holder.add(originalVelocities.get( i ));
        p.velocity.set(holder.x, holder.y, holder.z);
      }
    }
  }
} // RungeKuttaIntegrator

//===========================================================================================
//                                         Spring
//===========================================================================================
// May 29, 2005
//package traer.physics;
// @author jeffrey traer bernstein
public final class Spring implements Force {
  final float springConstant0;
  final float damping;
  final float restLength;
  final Particle one;
  final Particle b;
  boolean on = true;

  public Spring( Particle A, Particle B, float ks, float damping, float restLength )
  {
    springConstant0 = ks;
    this.damping = damping;
    this.restLength = restLength;
    one = A;
    b = B;
  }

  public  void     turnOff() { 
    on = false;
  }
  public void     turnOn() { 
    on = true;
  }
  public  boolean  isOn() { 
    return on;
  }

  public float    currentLength() { 
    return one.distanceTo( b );
  }

  public float    strength() { 
    return springConstant0;
  }


  public final void apply() {  
    if ( on && ( one.isFree() || b.isFree() ) ) {
      PVector a2b = PVector.sub(one.position, b.position, new PVector());

      float a2bDistance = a2b.mag();  

      if (a2bDistance!=0f) {
        a2b.div(a2bDistance);
      }

      // spring force is proportional to how much it stretched 
      float springForce = -( a2bDistance - restLength ) * springConstant0; 

      PVector vDamping = PVector.sub(one.velocity, b.velocity, new PVector());

      float dampingForce = -damping * a2b.dot(vDamping);

      // forceB is same as forceA in opposite direction
      float r = springForce + dampingForce;

      a2b.mult(r);

      if ( one.isFree() ) {
        one.force.add( a2b );
      }
      if ( b.isFree() ) {
        b.force.add( PVector.mult(a2b, -1, a2b) );
      }
    }
  }
} // Spring

//===========================================================================================
//                                       Smoother
//===========================================================================================
//package traer.animator;
public class Smoother implements Tickable {
  public float a;
  public float gain;
  public float lastOutput;
  public float input;

  public Smoother(float smoothness) { 
    this(smoothness, 0.0F);
  }
  public Smoother(float smoothness, float start) { 
    setSmoothness(smoothness); 
    setValue(start);
  }
  public final void setSmoothness(float smoothness) { 
    a = -smoothness; 
    gain = 1.0F + a;
  }
  public final void setTarget(float target) { 
    input = target;
  }
  public void setValue(float x) { 
    input = x; 
    lastOutput = x;
  }
  public final float getTarget() { 
    return input;
  }
  public final void tick() { 
    lastOutput = gain * input - a * lastOutput;
  }
  public final float getValue() { 
    return lastOutput;
  }
} // Smoother

//===========================================================================================
//                                      Smoother3D
//===========================================================================================
//package traer.animator;
public class Smoother3D implements Tickable {
  public Smoother x0, y0, z0;
  public Smoother3D(float smoothness) {
    x0 = new Smoother(smoothness);
    y0 = new Smoother(smoothness);
    z0 = new Smoother(smoothness);
  }
  public Smoother3D(float initialX, float initialY, float initialZ, float smoothness) {
    x0 = new Smoother(smoothness, initialX);
    y0 = new Smoother(smoothness, initialY);
    z0 = new Smoother(smoothness, initialZ);
  }
  public final void setXTarget(float X) { 
    x0.setTarget(X);
  }
  public final void setYTarget(float X) { 
    y0.setTarget(X);
  }
  public final void setZTarget(float X) { 
    z0.setTarget(X);
  }

  public final void setTarget(float X, float Y, float Z) {
    x0.setTarget(X);
    y0.setTarget(Y);
    z0.setTarget(Z);
  }
  public final void setValue(float X, float Y, float Z) {
    x0.setValue(X);
    y0.setValue(Y);
    z0.setValue(Z);
  }
  public final void setX(float X) { 
    x0.setValue(X);
  }
  public final void setY(float Y) { 
    y0.setValue(Y);
  }
  public final void setZ(float Z) { 
    z0.setValue(Z);
  }
  public final void setSmoothness(float smoothness) {
    x0.setSmoothness(smoothness);
    y0.setSmoothness(smoothness);
    z0.setSmoothness(smoothness);
  }
  public final void tick() { 
    x0.tick(); 
    y0.tick(); 
    z0.tick();
  }
  public final float x() { 
    return x0.getValue();
  }
  public final float y() { 
    return y0.getValue();
  }
  public final float z() { 
    return z0.getValue();
  }
} // Smoother3D

//===========================================================================================
//                                      Tickable
//===========================================================================================
//package traer.animator;
public interface Tickable {
  void tick();
  void setSmoothness(float f);
} // Tickable

