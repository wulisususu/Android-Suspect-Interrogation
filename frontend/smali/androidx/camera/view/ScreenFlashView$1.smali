.class Landroidx/camera/view/ScreenFlashView$1;
.super Ljava/lang/Object;
.source "ScreenFlashView.java"

# interfaces
.implements Landroidx/camera/core/ImageCapture$ScreenFlash;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/camera/view/ScreenFlashView;->updateScreenFlash(Landroid/view/Window;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private mAnimator:Landroid/animation/ValueAnimator;

.field private mPreviousBrightness:F

.field final synthetic this$0:Landroidx/camera/view/ScreenFlashView;


# direct methods
.method constructor <init>(Landroidx/camera/view/ScreenFlashView;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    iput-object p1, p0, Landroidx/camera/view/ScreenFlashView$1;->this$0:Landroidx/camera/view/ScreenFlashView;

    .line 177
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public apply(JLandroidx/camera/core/ImageCapture$ScreenFlashListener;)V
    .locals 0

    const-string p1, "ScreenFlashView"

    const-string p2, "ScreenFlash#apply"

    .line 184
    invoke-static {p1, p2}, Landroidx/camera/core/Logger;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Landroidx/camera/view/ScreenFlashView$1;->this$0:Landroidx/camera/view/ScreenFlashView;

    .line 186
    invoke-static {p1}, Landroidx/camera/view/ScreenFlashView;->access$000(Landroidx/camera/view/ScreenFlashView;)F

    move-result p1

    iput p1, p0, Landroidx/camera/view/ScreenFlashView$1;->mPreviousBrightness:F

    iget-object p1, p0, Landroidx/camera/view/ScreenFlashView$1;->this$0:Landroidx/camera/view/ScreenFlashView;

    const/high16 p2, 0x3f800000    # 1.0f

    .line 187
    invoke-static {p1, p2}, Landroidx/camera/view/ScreenFlashView;->access$100(Landroidx/camera/view/ScreenFlashView;F)V

    iget-object p1, p0, Landroidx/camera/view/ScreenFlashView$1;->mAnimator:Landroid/animation/ValueAnimator;

    if-eqz p1, :cond_0

    .line 190
    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->cancel()V

    :cond_0
    iget-object p1, p0, Landroidx/camera/view/ScreenFlashView$1;->this$0:Landroidx/camera/view/ScreenFlashView;

    .line 192
    invoke-static {p3}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    new-instance p2, Landroidx/camera/view/ScreenFlashView$1$$ExternalSyntheticLambda0;

    invoke-direct {p2, p3}, Landroidx/camera/view/ScreenFlashView$1$$ExternalSyntheticLambda0;-><init>(Landroidx/camera/core/ImageCapture$ScreenFlashListener;)V

    invoke-static {p1, p2}, Landroidx/camera/view/ScreenFlashView;->access$200(Landroidx/camera/view/ScreenFlashView;Ljava/lang/Runnable;)Landroid/animation/ValueAnimator;

    move-result-object p1

    iput-object p1, p0, Landroidx/camera/view/ScreenFlashView$1;->mAnimator:Landroid/animation/ValueAnimator;

    return-void
.end method

.method public clear()V
    .locals 2

    const-string v0, "ScreenFlashView"

    const-string v1, "ScreenFlash#clearScreenFlashUi"

    .line 197
    invoke-static {v0, v1}, Landroidx/camera/core/Logger;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Landroidx/camera/view/ScreenFlashView$1;->mAnimator:Landroid/animation/ValueAnimator;

    if-eqz v0, :cond_0

    .line 200
    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->cancel()V

    const/4 v0, 0x0

    iput-object v0, p0, Landroidx/camera/view/ScreenFlashView$1;->mAnimator:Landroid/animation/ValueAnimator;

    :cond_0
    iget-object v0, p0, Landroidx/camera/view/ScreenFlashView$1;->this$0:Landroidx/camera/view/ScreenFlashView;

    const/4 v1, 0x0

    .line 204
    invoke-virtual {v0, v1}, Landroidx/camera/view/ScreenFlashView;->setAlpha(F)V

    iget-object v0, p0, Landroidx/camera/view/ScreenFlashView$1;->this$0:Landroidx/camera/view/ScreenFlashView;

    iget v1, p0, Landroidx/camera/view/ScreenFlashView$1;->mPreviousBrightness:F

    .line 207
    invoke-static {v0, v1}, Landroidx/camera/view/ScreenFlashView;->access$100(Landroidx/camera/view/ScreenFlashView;F)V

    return-void
.end method
