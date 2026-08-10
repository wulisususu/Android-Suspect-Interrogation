.class public final synthetic Landroidx/camera/view/ScreenFlashView$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# instance fields
.field public final synthetic f$0:Landroidx/camera/view/ScreenFlashView;


# direct methods
.method public synthetic constructor <init>(Landroidx/camera/view/ScreenFlashView;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/camera/view/ScreenFlashView$$ExternalSyntheticLambda0;->f$0:Landroidx/camera/view/ScreenFlashView;

    return-void
.end method


# virtual methods
.method public final onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 1

    iget-object v0, p0, Landroidx/camera/view/ScreenFlashView$$ExternalSyntheticLambda0;->f$0:Landroidx/camera/view/ScreenFlashView;

    invoke-virtual {v0, p1}, Landroidx/camera/view/ScreenFlashView;->lambda$animateToFullOpacity$0$androidx-camera-view-ScreenFlashView(Landroid/animation/ValueAnimator;)V

    return-void
.end method
