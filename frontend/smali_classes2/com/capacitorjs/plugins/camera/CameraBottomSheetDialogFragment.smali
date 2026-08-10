.class public Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;
.super Lcom/google/android/material/bottomsheet/BottomSheetDialogFragment;
.source "CameraBottomSheetDialogFragment.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnSelectedListener;,
        Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnCanceledListener;
    }
.end annotation


# instance fields
.field private canceledListener:Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnCanceledListener;

.field private mBottomSheetBehaviorCallback:Lcom/google/android/material/bottomsheet/BottomSheetBehavior$BottomSheetCallback;

.field private options:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private selectedListener:Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnSelectedListener;

.field private title:Ljava/lang/String;


# direct methods
.method public static synthetic $r8$lambda$mwnP0zJKQebo3xCPcX1ghp_1z9M(Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;ILandroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->lambda$setupDialog$0(ILandroid/view/View;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 17
    invoke-direct {p0}, Lcom/google/android/material/bottomsheet/BottomSheetDialogFragment;-><init>()V

    .line 50
    new-instance v0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$1;

    invoke-direct {v0, p0}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$1;-><init>(Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;)V

    iput-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->mBottomSheetBehaviorCallback:Lcom/google/android/material/bottomsheet/BottomSheetBehavior$BottomSheetCallback;

    return-void
.end method

.method private synthetic lambda$setupDialog$0(ILandroid/view/View;)V
    .locals 0

    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->selectedListener:Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnSelectedListener;

    if-eqz p2, :cond_0

    .line 103
    invoke-interface {p2, p1}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnSelectedListener;->onSelected(I)V

    .line 105
    :cond_0
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->dismiss()V

    return-void
.end method


# virtual methods
.method public onCancel(Landroid/content/DialogInterface;)V
    .locals 0

    .line 44
    invoke-super {p0, p1}, Lcom/google/android/material/bottomsheet/BottomSheetDialogFragment;->onCancel(Landroid/content/DialogInterface;)V

    iget-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->canceledListener:Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnCanceledListener;

    if-eqz p1, :cond_0

    .line 46
    invoke-interface {p1}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnCanceledListener;->onCanceled()V

    :cond_0
    return-void
.end method

.method setOptions(Ljava/util/List;Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnSelectedListener;Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnCanceledListener;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnSelectedListener;",
            "Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnCanceledListener;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->options:Ljava/util/List;

    iput-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->selectedListener:Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnSelectedListener;

    iput-object p3, p0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->canceledListener:Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$BottomSheetOnCanceledListener;

    return-void
.end method

.method setTitle(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->title:Ljava/lang/String;

    return-void
.end method

.method public setupDialog(Landroid/app/Dialog;I)V
    .locals 5

    .line 65
    invoke-super {p0, p1, p2}, Lcom/google/android/material/bottomsheet/BottomSheetDialogFragment;->setupDialog(Landroid/app/Dialog;I)V

    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->options:Ljava/util/List;

    if-eqz p2, :cond_2

    .line 67
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    if-nez p2, :cond_0

    goto/16 :goto_1

    .line 71
    :cond_0
    invoke-virtual {p1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    .line 73
    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    invoke-virtual {p2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p2

    iget p2, p2, Landroid/util/DisplayMetrics;->density:F

    const/high16 v0, 0x41800000    # 16.0f

    mul-float/2addr v0, p2

    const/high16 v1, 0x3f000000    # 0.5f

    add-float/2addr v0, v1

    float-to-int v0, v0

    const/high16 v2, 0x41400000    # 12.0f

    mul-float/2addr v2, p2

    add-float/2addr v2, v1

    float-to-int v2, v2

    const/high16 v3, 0x41000000    # 8.0f

    mul-float/2addr p2, v3

    add-float/2addr p2, v1

    float-to-int p2, p2

    .line 82
    new-instance v1, Landroidx/coordinatorlayout/widget/CoordinatorLayout;

    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v1, v3}, Landroidx/coordinatorlayout/widget/CoordinatorLayout;-><init>(Landroid/content/Context;)V

    .line 84
    new-instance v3, Landroid/widget/LinearLayout;

    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v4, 0x1

    .line 85
    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 86
    invoke-virtual {v3, v0, v0, v0, v0}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 87
    new-instance v0, Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v0, v4}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const-string v4, "#757575"

    .line 88
    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setTextColor(I)V

    .line 89
    invoke-virtual {v0, p2, p2, p2, p2}, Landroid/widget/TextView;->setPadding(IIII)V

    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->title:Ljava/lang/String;

    .line 90
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 91
    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    const/4 p2, 0x0

    :goto_0
    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->options:Ljava/util/List;

    .line 93
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge p2, v0, :cond_1

    .line 96
    new-instance v0, Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v0, v4}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const-string v4, "#000000"

    .line 97
    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setTextColor(I)V

    .line 98
    invoke-virtual {v0, v2, v2, v2, v2}, Landroid/widget/TextView;->setPadding(IIII)V

    iget-object v4, p0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->options:Ljava/util/List;

    .line 99
    invoke-interface {v4, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 100
    new-instance v4, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$$ExternalSyntheticLambda0;

    invoke-direct {v4, p0, p2}, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment$$ExternalSyntheticLambda0;-><init>(Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;I)V

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 108
    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 111
    :cond_1
    invoke-virtual {v3}, Landroid/widget/LinearLayout;->getRootView()Landroid/view/View;

    move-result-object p2

    invoke-virtual {v1, p2}, Landroidx/coordinatorlayout/widget/CoordinatorLayout;->addView(Landroid/view/View;)V

    .line 113
    invoke-virtual {v1}, Landroidx/coordinatorlayout/widget/CoordinatorLayout;->getRootView()Landroid/view/View;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/app/Dialog;->setContentView(Landroid/view/View;)V

    .line 115
    invoke-virtual {v1}, Landroidx/coordinatorlayout/widget/CoordinatorLayout;->getParent()Landroid/view/ViewParent;

    move-result-object p1

    check-cast p1, Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    check-cast p1, Landroidx/coordinatorlayout/widget/CoordinatorLayout$LayoutParams;

    .line 116
    invoke-virtual {p1}, Landroidx/coordinatorlayout/widget/CoordinatorLayout$LayoutParams;->getBehavior()Landroidx/coordinatorlayout/widget/CoordinatorLayout$Behavior;

    move-result-object p1

    .line 118
    instance-of p2, p1, Lcom/google/android/material/bottomsheet/BottomSheetBehavior;

    if-eqz p2, :cond_2

    .line 119
    check-cast p1, Lcom/google/android/material/bottomsheet/BottomSheetBehavior;

    iget-object p2, p0, Lcom/capacitorjs/plugins/camera/CameraBottomSheetDialogFragment;->mBottomSheetBehaviorCallback:Lcom/google/android/material/bottomsheet/BottomSheetBehavior$BottomSheetCallback;

    .line 120
    invoke-virtual {p1, p2}, Lcom/google/android/material/bottomsheet/BottomSheetBehavior;->addBottomSheetCallback(Lcom/google/android/material/bottomsheet/BottomSheetBehavior$BottomSheetCallback;)V

    const/4 p2, 0x3

    .line 121
    invoke-virtual {p1, p2}, Lcom/google/android/material/bottomsheet/BottomSheetBehavior;->setState(I)V

    :cond_2
    :goto_1
    return-void
.end method
