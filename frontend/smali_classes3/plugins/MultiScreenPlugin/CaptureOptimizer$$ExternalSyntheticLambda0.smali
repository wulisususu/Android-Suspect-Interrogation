.class public final synthetic Lplugins/MultiScreenPlugin/CaptureOptimizer$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/view/PixelCopy$OnPixelCopyFinishedListener;


# instance fields
.field public final synthetic f$0:Lplugins/MultiScreenPlugin/CaptureOptimizer;

.field public final synthetic f$1:Landroid/graphics/Bitmap;

.field public final synthetic f$2:Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;


# direct methods
.method public synthetic constructor <init>(Lplugins/MultiScreenPlugin/CaptureOptimizer;Landroid/graphics/Bitmap;Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lplugins/MultiScreenPlugin/CaptureOptimizer$$ExternalSyntheticLambda0;->f$0:Lplugins/MultiScreenPlugin/CaptureOptimizer;

    iput-object p2, p0, Lplugins/MultiScreenPlugin/CaptureOptimizer$$ExternalSyntheticLambda0;->f$1:Landroid/graphics/Bitmap;

    iput-object p3, p0, Lplugins/MultiScreenPlugin/CaptureOptimizer$$ExternalSyntheticLambda0;->f$2:Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;

    return-void
.end method


# virtual methods
.method public final onPixelCopyFinished(I)V
    .locals 3

    iget-object v0, p0, Lplugins/MultiScreenPlugin/CaptureOptimizer$$ExternalSyntheticLambda0;->f$0:Lplugins/MultiScreenPlugin/CaptureOptimizer;

    iget-object v1, p0, Lplugins/MultiScreenPlugin/CaptureOptimizer$$ExternalSyntheticLambda0;->f$1:Landroid/graphics/Bitmap;

    iget-object v2, p0, Lplugins/MultiScreenPlugin/CaptureOptimizer$$ExternalSyntheticLambda0;->f$2:Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;

    invoke-static {v0, v1, v2, p1}, Lplugins/MultiScreenPlugin/CaptureOptimizer;->$r8$lambda$Gbqt7wcms_z258myf0A9ljBh1do(Lplugins/MultiScreenPlugin/CaptureOptimizer;Landroid/graphics/Bitmap;Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;I)V

    return-void
.end method
