CREATE TABLE `accounts` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`number` text NOT NULL,
	`customer_id` integer NOT NULL,
	`type` text NOT NULL,
	`status` text DEFAULT 'Active' NOT NULL,
	`balance_cents` integer DEFAULT 0 NOT NULL CHECK (`balance_cents` >= 0),
	`created_at` text NOT NULL,
	FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `accounts_number_uq` ON `accounts` (`number`);--> statement-breakpoint
CREATE INDEX `accounts_customer_idx` ON `accounts` (`customer_id`);--> statement-breakpoint
CREATE TABLE `beneficiaries` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`owner_account_id` integer NOT NULL,
	`target_account_id` integer NOT NULL,
	`nickname` text NOT NULL,
	`created_at` text NOT NULL,
	FOREIGN KEY (`owner_account_id`) REFERENCES `accounts`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`target_account_id`) REFERENCES `accounts`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `beneficiaries_owner_target_uq` ON `beneficiaries` (`owner_account_id`,`target_account_id`);--> statement-breakpoint
CREATE TABLE `customers` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`email` text NOT NULL,
	`phone` text NOT NULL,
	`created_at` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `customers_email_uq` ON `customers` (`email`);--> statement-breakpoint
CREATE TABLE `entries` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`movement_id` integer NOT NULL,
	`account_id` integer NOT NULL,
	`direction` text NOT NULL,
	`amount_cents` integer NOT NULL,
	`balance_after_cents` integer NOT NULL,
	`created_at` text NOT NULL,
	FOREIGN KEY (`movement_id`) REFERENCES `movements`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`account_id`) REFERENCES `accounts`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE INDEX `entries_account_idx` ON `entries` (`account_id`);--> statement-breakpoint
CREATE INDEX `entries_movement_idx` ON `entries` (`movement_id`);--> statement-breakpoint
CREATE TABLE `movements` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`reference` text NOT NULL,
	`kind` text NOT NULL,
	`source_id` integer,
	`destination_id` integer,
	`amount_cents` integer NOT NULL CHECK (`amount_cents` > 0 AND `amount_cents` <= 100000000),
	`memo` text DEFAULT '' NOT NULL,
	`created_at` text NOT NULL,
	FOREIGN KEY (`source_id`) REFERENCES `accounts`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`destination_id`) REFERENCES `accounts`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `movements_reference_uq` ON `movements` (`reference`);--> statement-breakpoint
CREATE INDEX `movements_source_idx` ON `movements` (`source_id`);--> statement-breakpoint
CREATE INDEX `movements_destination_idx` ON `movements` (`destination_id`);
